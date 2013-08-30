Gem::Specification.new do |s|
  s.platform    = 'java'
  s.name        = 'emf_jruby'
  s.version     = '0.2.1'
  s.date        = '2013-08-30'
  s.summary     = "EMF support for JRuby"
  s.description = "EMF support for JRuby"
  s.authors     = ["Federico Tomassetti"]
  s.email       = 'f.tomassetti@gmail.com'
  s.homepage    = 'http://federico-tomassetti.it'

  s.files       = [
	   "lib/emf_jruby.rb"
  ]

  curr_dir = File.dirname(__FILE__)
  Dir[curr_dir+"/lib/emf/*.rb"].each do |rb|
    s.files << rb
  end
  Dir[curr_dir+"/lib/jars/*.jar"].each do |f|
    s.files << f
  end

  s.add_dependency('json')
end