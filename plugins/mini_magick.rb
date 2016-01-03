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
       def initialize(site, base, dir, name, options)
         @site = site
         @base = base
         @dir  = dir
         @name = name

         thumbs_dir = site.config['mini_magick']['thumbnail_dir']

         @dst_dir = File.join(@dir, thumbs_dir)
         @commands = options
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

       # Find all image files in the source directories of the presets specified
       # in the site config.  Add a GeneratedImageFile to the static_files stack
       # for later processing.
       def generate(site)
         return unless site.config['mini_magick']

         options = site.config['mini_magick']['options']
         galleries_path = site.config['mini_magick']['galleries_path']
         thumbs_dir = site.config['mini_magick']['thumbnail_dir']

         site.posts.map { |post| post.data["gallery"] }.compact.each do |gallery|
           Dir.glob(File.join(site.source, galleries_path, gallery, "*.{png,jpg,jpeg, gif}")) do |image|
             site.static_files << GeneratedImageFile.new(site, site.source, File.join(galleries_path, gallery), File.basename(image), options)
           end
         end
       end
     end

   end
 end
