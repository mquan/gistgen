require 'uri'
require 'json'

require "gistgen/page"
require "gistgen/string"

module Gistgen
  class WikiAbstract
    
    def self.permalink(name)
      "http://en.wikipedia.org/wiki/#{name}"
    end
    
    def self.search(query, length=500)
      q = URI.escape(query)
      res = Gistgen::Page.get_page("http://en.wikipedia.org/w/api.php?format=json&action=query&prop=revisions&titles=#{q}&rvprop=content&rvsection=0")
      json = JSON.parse(res)
      rev=0
      json['query']['pages'].each_key { |k| rev=k }
      all_text = ''
      text = json['query']['pages'][rev]['revisions'][0]['*'].to_s
      if text.include?('#REDIRECT')
        new_q = text.match(/\[\[(.*?)\]\]/)[0].gsub('[','').gsub(']','')
        all_text = WikiAbstract.search(new_q)
      else
        t = text[text.index("'''")...text.size].gsub(/^\s+/,'')
        all_text = t.gsub(/<ref>(.*?)<\/ref>/i,'').gsub(/<small>(.*?)<\/small>/,'').gsub(/<(.*?)>/,'').gsub(/\{\{(.*?)\}\}/,'').gsub(/\(stylized(.*?)\)/,'').gsub(/\[\[([^\]\]]*?)\|/,'')
        ["[","]","'''"].each { |g,clean| all_text.gsub!(g,'') }
      end
      all_text.extract_passage(0, length)
    end
    
  end
end