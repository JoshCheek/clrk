# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "clrk/version"

Gem::Specification.new do |s|
  s.name        = "clrk"
  s.version     = CLRK::VERSION
  s.authors     = ["Josh Cheek"]
  s.email       = ["josh.cheek@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Koans to learn Ruby command-line fu}
  s.description = %q{Koans that will teach you what you need to know to use Ruby in place of sed/awk/grep}

  s.rubyforge_project = "clrk"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec",     "~> 2.8.0"
  s.add_development_dependency "cucumber",  "~> 1.1.8"
  s.add_development_dependency "fakefs",    "~> 0.4.0"
  s.add_development_dependency "pry"
  # s.add_runtime_dependency "rest-client"
end
