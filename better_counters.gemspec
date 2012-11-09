# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "better_counters/version"

Gem::Specification.new do |s|
  s.name        = "better_counters"
  s.version     = BetterCounters::VERSION
  s.authors     = ["Ryan Sacha"]
  s.email       = ["ryan@ryansacha.com"]
  s.homepage    = "https://github.com/RyanSacha/BetterCounters"
  s.summary     = %q{Independent counter cache outside belongs_to}
  s.description = %q{Improved alternative to rails built-in counter cache to work outside belongs_to}

  s.rubyforge_project = "better_counters"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "activerecord"
end
