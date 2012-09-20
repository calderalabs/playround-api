# -*- encoding: utf-8 -*-
require File.expand_path('../lib/adjust_string/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Matteo Depalo"]
  gem.email         = ["matteodepalo@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "adjust_string"
  gem.require_paths = ["lib"]
  gem.version       = AdjustString::VERSION

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'supermodel'
end
