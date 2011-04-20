require "#{File.dirname(__FILE__)}/../lib/gistgen"

puts Gistgen::HackerNews.get_score('http://news.ycombinator.com/item?id=2458202')
puts Gistgen::HackerNews.frontpage
puts Gistgen::HackerNews.new_posts

puts Gistgen::Reddit.fetch("http://reddit.com/")
puts Gistgen::Reddit.get_score('http://www.reddit.com/r/funny/comments/gu7jw/dictator/')