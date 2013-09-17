# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'emf/version'

Gem::Specification.new do |s|
  s.platform    = 'java'
  s.name        = 'emf_jruby'
  s.version     = EMF::VERSION
  s.date        = '2013-09-13'
  s.summary     = "EMF support for JRuby"
  s.description = "EMF support for JRuby"
  s.authors     = ["Federico Tomassetti"]
  s.email       = 'f.tomassetti@gmail.com'
  s.homepage    = 'https://github.com/ftomassetti/emf_jruby'
  s.license     = "APACHE2"

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_dependency('json')
  s.add_dependency('rgen')

  s.add_development_dependency "bundler", "~> 1.3"
  s.add_development_dependency "rake"
end