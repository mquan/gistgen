require 'json'
require 'htmlentities'

require "gistgen/page"
require "gistgen/string"
require "gistgen/url"

module Gistgen
  class CrunchView    
    def initialize(name)
      begin
        res = Gistgen::Page.get_page("http://api.crunchbase.com/v/1/company/#{name}.js")
        @json = JSON.parse(res)
        @json = (@json and @json['overview'])? @json : nil
      rescue
        nil
      end   
    end
    
    #add method returning hash of everything for a resource
    
    def overview(length=500)
      begin
        text = @json['overview'].gsub(/\u003C(.*?)\\u003E/,'').gsub(/<(.*?)>/,'').gsub("\n",'')
        text = HTMLEntities.new.decode(text) #decode_html
        text.extract_passage(0, length)
      rescue
        nil
      end
    end
    
    def permalink
      begin
        Gistgen::URL.standardize("http://www.crunchbase.com/company/#{@json['permalink']}")
      rescue
        nil
      end
    end

    def homepage
      (@json)? Gistgen::URL.standardize(@json['homepage_url']) : nil
    end
    
  end
end

