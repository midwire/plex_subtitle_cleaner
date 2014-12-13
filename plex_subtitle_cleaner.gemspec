# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'plex_subtitle_cleaner/version'

Gem::Specification.new do |spec|
  spec.name          = 'plex_subtitle_cleaner'
  spec.version       = PlexSubtitleCleaner::VERSION
  spec.authors       = ['Chris Blackburn']
  spec.email         = ['chris@midwiretech.com']
  spec.summary       = 'Clean subtitles for your Plex database.'
  spec.description   = spec.summary
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'trollop'
  spec.add_dependency 'colored'
  spec.add_dependency 'midwire_common', '~> 0.1.11'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-nav'
  spec.add_development_dependency 'rspec', '~> 3.1'
  spec.add_development_dependency 'guard', '2.10.1'
  spec.add_development_dependency 'guard-rspec', '4.3.1'
end
