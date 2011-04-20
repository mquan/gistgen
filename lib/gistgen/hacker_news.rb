require 'json'

require 'gistgen/page'
require 'gistgen/url'

module Gistgen
  class HackerNews
    #http://api.ihackernews.com/        
    def self.frontpage
      begin
        res = Gistgen::Page.get_page("http://api.ihackernews.com/page")
        Gistgen::HackerNews.get_hash(res)
      rescue
        nil
      end
    end
    
    #don't use this too often (low score shouldn't be added)
    def self.new_posts
      begin
        res = Gistgen::Page.get_page("http://api.ihackernews.com/new")
        Gistgen::HackerNews.get_hash(res)
      rescue
        nil
      end
    end
    
    def self.get_score(hn_url)
      id = hn_url.match(/\d+$/)[0]
      begin
        res = Gistgen::Page.get_page("http://api.ihackernews.com/post/#{id}")
        json = JSON.parse(res)
        json['points']
      rescue
        nil
      end
    end
    
    def self.get_hash(res)
      json = JSON.parse(res)
      json['items'].map do |i| 
        {"title" => i['title'], 
          "url" => Gistgen::URL.standardize(i['url']), 
          "score" => i['points'], 
          "time" => Gistgen::HackerNews.parse_time(i['postedAgo']),
          "discussion_url" => "http://news.ycombinator.com/item?id=#{i['id']}"
        }
      end
    end
    
    def self.parse_time(time_ago)
      begin
        tmp = time_ago.split(' ')
        time = tmp[0].to_i.send(tmp[1]).ago
      rescue
        Time.now.utc
      end
    end
    
  end
end