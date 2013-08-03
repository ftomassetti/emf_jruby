require 'test/unit'
require 'rgen/metamodel_builder'

class Person < RGen::MetamodelBuilder::MMBase
	has_attr :name, String
end

class TestRgenToEmf < Test::Unit::TestCase

	def test_gen_eclass
		
	end

end