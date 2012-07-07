module Jekyll

  # CoffeeScript plugin to convert .coffee to .js
  class CoffeeScriptConverter < Converter
    safe true
    priority :normal

    def initialize(config)
      require 'coffee-script' unless (defined?(::CoffeeScript))
      sconfig = { "extension" => :coffee }
      @config = sconfig.inject({}) { |i, (k, v)| i[k.to_sym] = v; i }
    rescue LoadError
      STDERR.puts 'You are missing a library required for CoffeeScript. Please run:'
      STDERR.puts '  $ [sudo] gem install coffeescript'
      STDERR.puts 'Skipping CoffeeScript generation.'
    end

    def matches(ext)
      ext =~ /\.#{@config[:extension].to_s}/io
    end

    def output_ext(ext)
      ".js"
    end

    def convert(content)
      return content unless defined?(::CoffeeScript)
      CoffeeScript.compile content
    rescue StandardError => e
      puts "!!! CoffeeScript Error:" + e.message
    end
  end  
end