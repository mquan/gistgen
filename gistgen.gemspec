# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "gistgen/version"

Gem::Specification.new do |s|
  s.name        = "gistgen"
  s.version     = Gistgen::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Quan Nguyen"]
  s.email       = ["mquannie@gmail.com"]
  s.homepage    = "http://github.com/mquan/gistgen"
  s.summary     = %q{generate different types of summaries for a text}
  s.description = %q{gistgen has several modules to generate summaries from wikipedia and crunchbase}
  s.rubyforge_project = "gistgen"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency "mechanize"
  s.add_dependency "json"
  s.add_dependency "htmlentities"  
end
