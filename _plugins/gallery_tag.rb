module ImageList
  def image_list( name )
    build_dir = @context.registers[:site].config["destination"]
    base_dir = @context.registers[:site].config["mini_magick"]["galleries_path"]
    thumbs_dir = @context.registers[:site].config["mini_magick"]["thumbnail_dir"]

    list = Array.new
    dir = Dir.new( File.join(build_dir, base_dir, name) )
    dir.each do | d |
      image = File.basename(d, File.extname(d))
      unless d =~ /^\./ || d =~ /#{thumbs_dir}/
        list << %Q{<a class="fancybox" href="/#{base_dir}/#{name}/#{d}" rel="shadowbox" title="#{image}"><img src="/#{base_dir}/#{name}/#{thumbs_dir}/#{d}" /></a>}
      end
    end
    list.sort.join( "\n" )
  end
end

Liquid::Template.register_filter(ImageList)
