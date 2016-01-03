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
       def initialize(site, base, dir, name, preset, gallery)
         @site = site
         @base = base
         @dir  = dir
         @name = name
         @gallery = gallery

         galleries_path = site.config['mini_magick']['galleries_path']
         thumbs_dir = site.config['mini_magick']['thumbnail_dir']

         @dst_dir = File.join(File.dirname(base), site.config['destination'], galleries_path, gallery, thumbs_dir)
         @src_dir = File.join(base, galleries_path, gallery)
         @commands = preset
       end

       # Returns source file path.
       def path
         File.join(@src_dir, @name)
       end

       # Returns false if the file was not modified since last time (no-op).
       def write(dest)
         dest_path = File.join(@dst_dir, @name)

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

         site.posts.map { |post| post.data["gallery"] }.compact.each do |name|
           Dir.glob(File.join(site.source, galleries_path, name, "*.{png,jpg,jpeg, gif}")) do |source|
             site.static_files << GeneratedImageFile.new(site, site.source, File.join(File.dirname(source), thumbs_dir), File.basename(source), options, name)
           end
         end
       end
     end

   end
 end
