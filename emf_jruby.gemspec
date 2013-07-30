Gem::Specification.new do |s|
  s.platform    = 'java'
  s.name        = 'emf_jruby'
  s.version     = '0.1.0'
  s.date        = '2013-07-30'
  s.summary     = "EMF support for JRuby"
  s.description = "EMF support for JRuby. Support for loading and saving models in JSon."
  s.authors     = ["Federico Tomassetti"]
  s.email       = 'f.tomassetti@gmail.com'
  s.homepage    = 'http://federico-tomassetti.it'
  s.files       = [
	"lib/emf_jruby.rb",
	"lib/emf/emf_to_json.rb",
	"lib/emf/ast_serialization.rb",
	"lib/jars/org.antlr.runtime_3.0.0.v200803061811.jar",
	"lib/jars/org.eclipse.emf.common_2.8.0.v20130125-0546.jar",
	"lib/jars/org.eclipse.emf.ecore.xmi_2.8.1.v20130125-0546.jar",
	"lib/jars/org.eclipse.emf.ecore_2.8.3.v20130125-0546.jar",
	"lib/jars/org.eclipse.m2m.atl.common_3.3.1.v201209061455.jar",
	"lib/jars/org.eclipse.m2m.atl.core.emf_3.3.1.v201209061455.jar",
	"lib/jars/org.eclipse.m2m.atl.core_3.3.1.v201209061455.jar",
	"lib/jars/org.eclipse.m2m.atl.dsls_3.3.1.v201209061455.jar",
	"lib/jars/org.eclipse.m2m.atl.engine_3.3.1.v201209061455.jar"]
end