require 'mechanize'

module Gistgen
  class Page
    #make http request and return the html page
    def self.get_page(url, user_agent='gistgen gem request')
      begin
        agent = Mechanize.new
        agent.user_agent = user_agent
        agent.get(url)
        agent.page.body
      rescue
        nil
      end
    end
    
  end
end