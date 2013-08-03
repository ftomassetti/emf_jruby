$: << '../../emf_jruby/lib'

require 'test/unit'
require 'emf_jruby'
require 'emf/rgen_to_emf'
require 'rgen/metamodel_builder'

class Person < RGen::MetamodelBuilder::MMBase
	has_attr name, String
end

class TestRgenToEmf < Test::Unit::TestCase

	def test_gen_eclass_a_simple_attr_is_added
		emf_eclass = EMF.rgen_to_eclass Person
		assert_equal 1, emf_eclass.getEAttributes.size
	end

end
