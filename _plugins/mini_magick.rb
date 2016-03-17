require 'mini_magick'

 module Jekyll
   module JekyllMinimagick

     class GeneratedImageFile < Jekyll::StaticFile
       # Initialize a new GeneratedImage.
       #   +site+ is the Site
       #   +base+ is the String path to the <source>
       #   +dir+ is the String path between <source> and the file
       #   +name+ is the String filename of the file
       #   +preset+ is the Preset hash from the config.
       #
       # Returns <GeneratedImageFile>
       def initialize(site, src_dir, dst_dir, name)
         @site = site
         @base = site.source
         @dir  = src_dir
         @dst_dir = dst_dir
         @name = name
         @commands = site.config['mini_magick']['options']
       end

       def destination dest
         File.join(dest, @dst_dir, @name)
       end

       # Returns false if the file was not modified since last time (no-op).
       def write(dest)
         dest_path = destination(dest)

         puts "#{dest_path}"

         return false if File.exist? dest_path and !modified?

         @@mtimes[path] = mtime

         FileUtils.mkdir_p(File.dirname(dest_path))
         image = ::MiniMagick::Image.open(path)

         @commands.each do |option|
           option.each_pair do |command, arg|
             image.combine_options do |c|
               c.send command, arg
             end
           end
         end

         image.write dest_path
         puts "Writing to #{dest_path}"
         true
       end

     end

     class MiniMagickGenerator < Generator
       safe true
       priority :highest

       # Find all image files in the source directories of the presets specified
       # in the site config.  Add a GeneratedImageFile to the static_files stack
       # for later processing.
       def generate(site)
         return unless site.config['mini_magick']

         galleries_path = site.config['mini_magick']['galleries_path']
         thumbs_dir = site.config['mini_magick']['thumbnail_dir']

         site.posts.docs.map { |post| post.data["gallery"] }.compact.each do |gallery|
           Dir.glob(File.join(site.source, galleries_path, gallery, "*.{png,jpg,jpeg, gif}")) do |image|
             src_dir = File.join(galleries_path, gallery)
             dst_dir = File.join(src_dir, thumbs_dir)
             file = GeneratedImageFile.new(site, src_dir, dst_dir, File.basename(image))
             site.static_files << file
             file.write(site.config["destination"])
           end
         end
       end
     end

   end
 end
