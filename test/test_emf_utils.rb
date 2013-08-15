require 'emf_jruby'
require 'test/unit'
require 'rgen/metamodel_builder'

java_import org.eclipse.emf.ecore.EClass
java_import org.eclipse.emf.ecore.EObject
java_import org.eclipse.emf.ecore.EReference
java_import org.eclipse.emf.ecore.EAttribute

class TestRgenToEmf < Test::Unit::TestCase

	Pack = EMF.create_epackage('my_pack','my_pack_uri')

	Person = EMF.create_eclass Pack
	Person.eStructuralFeatures.add EMF.create_eattribute_str('name')

	def test_create_eclass
		ec = EMF.create_eclass
		assert ec.is_a? EClass
	end

	def test_create_eattribute
		ea = EMF.create_eattribute('name', EMF::EcoreLiterals::ESTRING)
		assert ea.is_a? EAttribute
		assert_equal 'name', ea.name
		assert_equal EMF::EcoreLiterals::ESTRING, ea.etype
	end

	def test_create_ereference_without_any_info
		er = EMF.create_ereference
		assert er.is_a? EReference
	end

	def test_create_ereference
		er = EMF.create_ereference(Person,'p')
		assert er.is_a? EReference
		assert_equal Person, er.etype
		assert_equal 'p',er.name
	end


	def test_create_eobject
		someEClass = EMF.create_eclass
		eo = EMF.create_eobject(someEClass)
		assert eo.is_a? EObject
	end

	def test_create_epackage
		ep = EMF.create_epackage('n','u')
		assert_equal 'n', ep.getName
		assert_equal 'u', ep.getNsURI
	end

end