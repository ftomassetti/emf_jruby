require 'emf_jruby'
require 'test/unit'
require 'rgen/metamodel_builder'

class Person < RGen::MetamodelBuilder::MMBase
	has_attr 'name', String
end

class Task < RGen::MetamodelBuilder::MMBase
end

class Project < RGen::MetamodelBuilder::MMBase
	contains_many 'tasks', Task, 'project'
	has_many 'personnel', Person
end

class TestRgenToEmf < Test::Unit::TestCase

	def test_gen_eclass_a_simple_attr_is_added
		emf_eclass = EMF.rgen_to_eclass Person
		assert_equal 1, emf_eclass.getEAttributes.size
		attr_name = emf_eclass.getEAttributes[0]
		assert_equal 'name', attr_name.name
		assert_equal EMF::EcoreLiterals.ESTRING,attr_name.getEType
	end

	def test_gen_eclass_a_simple_containement_is_added
		emf_eclass = EMF.rgen_to_eclass Project
		assert_equal 2, emf_eclass.getEReferences.size
		ref_tasks = get_ref_by_name(emf_eclass,'tasks')
		assert_equal true, ref_tasks.containment
		#type assert_equal EMF::EcoreLiterals.ESTRING,attr_name.getEType
	end

	def test_gen_eclass_a_simple_non_containement_is_added
		emf_eclass = EMF.rgen_to_eclass(Project)
		assert_equal 2, emf_eclass.getEReferences.size
		ref_pers = get_ref_by_name(emf_eclass,'personnel')
		assert_equal false, ref_pers.containment
		#type assert_equal EMF::EcoreLiterals.ESTRING,attr_name.getEType
	end

	def get_ref_by_name(eclass,name)
		refs = eclass.getEReferences.select {|r| r.name==name}
		assert_equal 1,refs.count
		refs[0]
	end

end
