require 'sinatra/base'

module Sinatra
  module ClearHead
    def meta
      html="<meta charset=\"utf-8\" /><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, minimum-scale=1.0\"/>"
      html << "<meta name=\"description\"content=\"#{settings.desc}\"  />" if settings.desc
      html << "<meta name=\"author\" content=\"#{settings.author}\" />" if settings.author
    end

    def favicon
      "<link href=\"/favicon.ico\" rel=\"shortcut icon\" />"
    end

    def ie_shim
      "<!--[if lt IE 9]><script src=\"http://html5shiv.googlecode.com/svn/trunk/html5.js\"></script><![endif]-->"
    end

    def title value=nil
      @title = value || settings.title || "untitled"
    end

    def title_tag
      "<title>#{@title}</title>"
    end

    def path_to script
      case script
        when :jquery then 'https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js'
        when :rightjs then 'http://cdn.rightjs.org/right-2.3.0.js'
        when :backbone then 'http://cdnjs.cloudflare.com/ajax/libs/backbone.js/0.9.0/backbone-min.js'
        when :underscore then 'http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.3.1/underscore-min.js'
        #moo, prototype, scriptaculous, jquery ui, yui, dojo, raphael, extjs      
        else "/javascripts/#{script}.js"
      end
    end

    def javascripts(*args)
      js = []
      js << settings.javascripts if settings.respond_to?('javascripts')
      js << args
      js << @js if @js
      js.flatten.uniq.map do |script| 
        "<script src=\"#{path_to script}\"></script>"
      end.join
    end

    def js(*args)
      @js ||= []
      @js = args
    end

    def styles(*args)
        css = []
        css << settings.css if settings.respond_to?('css')
        css << args
        css << @css if @css
        css.flatten.uniq.map do |stylesheet| 
          "<link href=\"/#{stylesheet}.css\" media=\"screen, projection\" rel=\"stylesheet\" />"
        end.join    
    end

    def css(*args)
      @css ||= []
      @css += args
    end

    def webfonts(*args)
      "<link href=\"http://fonts.googleapis.com/css?family=#{((@fonts?settings.fonts+@fonts:settings.fonts)+args).uniq.*'|'}\" rel=\"stylesheet\" />"
    end
  end
  
  helpers ClearHead
end
