module ImageList
  def image_list( name )
    base_dir = context.registers[:site].config[:mini_magick][:galleries_path]
    list = Array.new
    dir = Dir.new( File.join(base_dir, name) )
    dir.each do | d |
      image = File.basename(d, File.extname(d))
      unless d =~ /^\./ || d =~ /thumbs/
        list << %Q{<a href="/images/galleries/#{name}/#{d}" rel="shadowbox" title="#{image}"><img src="/images/galleries/#{name}/thumbs/#{d}" /></a>}
      end
    end
    list.sort.join( "\n" )
  end
end

Liquid::Template.register_filter(ImageList)
