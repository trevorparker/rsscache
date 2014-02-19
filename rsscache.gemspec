# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rsscache/version'

Gem::Specification.new do |spec|
  spec.name          = 'rsscache'
  spec.version       = RSSCache::Version::STRING
  spec.authors       = ['Trevor Parker']
  spec.email         = ['trevor@trevorparker.com']
  spec.summary       = %q{An RSS fetching and caching library.}
  spec.description   = ''
  spec.homepage      = 'https://github.com/trevorparker/rsscache'
  spec.license       = 'Modified BSD'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
end
