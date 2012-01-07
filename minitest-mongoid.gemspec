# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "minitest-mongoid/version"

Gem::Specification.new do |s|
  s.name        = "minitest-mongoid"
  s.version     = MinitestMongoid::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Brendon Murphy"]
  s.email       = ["xternal1+github@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Mongoid assertion matchers for MiniTest}
  s.description = s.summary

  s.rubyforge_project = "minitest-mongoid"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "mongoid"
  s.add_dependency "minitest"

  s.add_development_dependency "rake"
end
