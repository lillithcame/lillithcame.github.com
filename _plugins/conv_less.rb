module Jekyll
  class LessConverter < Converter
    safe true
    priority :high
    
    def initialize(config)
      @source = config["source"]
    end

    def setup
      return if @setup
      require 'less'
      @setup = true
    rescue LoadError
      STDERR.puts 'You are missing the library required for less. Please run:'
      STDERR.puts ' $ [sudo] gem install less'
      raise FatalException.new("Missing dependency: less")
    end
    
    def matches(ext)
      ext =~ /less|lcss/i
    end
    
    def output_ext(ext)
      ".css"
    end
    
    def convert(content)
      setup
      begin
        p = Less::Parser.new :paths => [File.join(@source, "/css")]
        c = p.parse(content)
        puts "."
        puts c
        c.to_css
      rescue => e
        puts "Less Exception: #{e.message}"
      end
    end
  end
end