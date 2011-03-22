require "#{File.dirname(__FILE__)}/../lib/gistgen"

cv = Gistgen::CrunchView.new('google')
puts cv.permalink
puts cv.overview