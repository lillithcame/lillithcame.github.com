module Jekyll
  
  # {% timestamp %} => 2089309470982
  class TimestampTag < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
    end

    def render(context)
        "#{Time.now.to_i}"
    end
  end
  
  # {% asset /some/file %} => /some/file?2098309840
  class AssetTag < Liquid::Tag
    def initialize(tag, text, tokens)
      @path = text.sub(/^\//, "")
    end
    
    def render(context)
      "/#{@path.strip}?#{Time.now.to_i}"
    end
  end
end

Liquid::Template.register_tag('timestamp', Jekyll::TimestampTag)
Liquid::Template.register_tag('asset', Jekyll::AssetTag)