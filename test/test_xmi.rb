require 'emf_jruby'
require 'rgen/metamodel_builder'
require 'test/unit'

class Person < RGen::MetamodelBuilder::MMBase
	has_attr 'name', String;
end

class TestRgenToEmf < Test::Unit::TestCase

	XmiStr = "<?xml version=\"1.0\" encoding=\"ASCII\"?>\n<ecore:EClass xmi:version=\"2.0\" xmlns:xmi=\"http://www.omg.org/XMI\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:ecore=\"http://www.eclipse.org/emf/2002/Ecore\">\n  <eStructuralFeatures xsi:type=\"ecore:EAttribute\" name=\"name\">\n    <eType xsi:type=\"ecore:EDataType\" href=\"http://www.eclipse.org/emf/2002/Ecore#//EString\"/>\n  </eStructuralFeatures>\n</ecore:EClass>\n"

	def test_eclass_to_xmi
		ec = EMF.rgen_to_eclass(Person)		
		assert_equal XmiStr,EMF::XmiConversion::to_xmi(ec)
	end

	def test_eclass_to_xmi_with_monkeypatching
		ec = EMF.rgen_to_eclass(Person)		
		assert_equal XmiStr,ec.to_xmi
	end

end