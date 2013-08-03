Gem::Specification.new do |s|
  s.platform    = 'java'
  s.name        = 'emf_jruby'
  s.version     = '0.1.7'
  s.date        = '2013-08-03'
  s.summary     = "EMF support for JRuby"
  s.description = "EMF support for JRuby. Support for loading and saving models in JSon."
  s.authors     = ["Federico Tomassetti"]
  s.email       = 'f.tomassetti@gmail.com'
  s.homepage    = 'http://federico-tomassetti.it'
  s.files       = [
	"lib/emf_jruby.rb",
	"lib/emf/emf_to_json.rb",
	"lib/emf/emf_nav.rb",
	"lib/emf/ast_serialization.rb",
  "lib/emf/eobject_util.rb",
  "lib/emf/model.rb",
  "lib/emf/xmi.rb",
  "lib/emf/stats.rb",
  "lib/emf/rgen_to_emf.rb",
	"lib/jars/org.antlr.runtime_3.0.0.v200803061811.jar",
	"lib/jars/org.eclipse.emf.common_2.8.0.v20130125-0546.jar",
	"lib/jars/org.eclipse.emf.ecore.xmi_2.8.1.v20130125-0546.jar",
	"lib/jars/org.eclipse.emf.ecore_2.8.3.v20130125-0546.jar"]
  s.add_dependency('json')
end