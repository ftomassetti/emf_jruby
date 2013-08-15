require 'emf_jruby'
require 'test/unit'
require 'rgen/metamodel_builder'

java_import org.eclipse.emf.ecore.EClass
java_import org.eclipse.emf.ecore.EObject
java_import org.eclipse.emf.ecore.EReference
java_import org.eclipse.emf.ecore.EAttribute

class TestRgenToEmf < Test::Unit::TestCase

	class SomeRgenMMClass < RGen::MetamodelBuilder::MMBase
	end

	SomeEClass = SomeRgenMMClass.to_eclass

	def test_create_eclass
		ec = EMF.create_eclass
		assert ec.is_a? EClass
	end

	def test_create_eattribute
		ea = EMF.create_eattribute
		assert ea.is_a? EAttribute
	end

	def test_create_ereference
		er = EMF.create_ereference
		assert er.is_a? EReference
	end

	def test_create_eobject
		eo = EMF.create_eobject(SomeEClass)
		assert eo.is_a? EObject
	end

end