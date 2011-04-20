require 'json'

require 'gistgen/page'
require 'gistgen/url'

module Gistgen
  class Reddit
    #http://code.reddit.com/wiki/API
    #reddit api is so nice, you just pick a page and add .json to get just the data
    #ex: http://www.reddit.com/.json
    def self.fetch(url)
      res = Gistgen::Page.get_page("#{url.gsub(/\/$/,'')}/.json")
      Gistgen::Reddit.get_hash(res)
    end
    
    def self.get_score(reddit_url)
      begin
        res = Gistgen::Page.get_page("#{reddit_url.gsub(/\/$/,'')}/.json")
        score = res.scan(/"score"\s*:\s*(\d+)/)[0] #reddit nested comments is too deep for json
      rescue
        nil
      end
    end
    
    def self.get_hash(res)
      json = JSON.parse(res)
      items = json['data']['children']
      items.map do |i|
        post = i['data']
        {"title" => post['title'], 
          "url" => Gistgen::URL.standardize(post['url']), 
          "score" => post['score'], 
          "time" => Time.at(post['created_utc']),
          "discussion_url" => "http://reddit.com#{post['permalink']}"
        }
      end
    end
    
    #ban digg: they link to their url shortener
    #http://developers.digg.com/documentation
    #require 'uri'
    #def self.get_diggs(url)
    #  res = Gistgen::Page.get_page(URI.escape(url)) #need to encode url
    #  json = JSON.parse(res)
    #  json['stories'][0]['diggs']
    #end
  end
end