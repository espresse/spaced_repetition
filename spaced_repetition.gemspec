# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "spaced_repetition"
  s.version = "1.0.0"
  s.platform = Gem::Platform::RUBY
  s.authors = ["Michał Ostrowski"]
  s.email = ["michol@linuxcsb.org"]
  s.summary = %q{Ruby gem for calculating spaced repetition intervals}
  s.description = %q{Ruby gem for calculating spaced repetition intervals.}

  s.files = `git ls-files`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency("bundler", ["~> 1.0"])
end
