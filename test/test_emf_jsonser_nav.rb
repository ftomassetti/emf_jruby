require 'emf_jruby'
require 'test/unit'

java_import org.eclipse.emf.ecore.EClass

# class Person < RGen::MetamodelBuilder::MMBase
# 	has_attr 'name', String
# 	has_one 'address', Address
# end

# class Address < RGen::MetamodelBuilder::MMBase
# 	has_attr 'city', String
# 	has_attr 'street', String
# end

# class Task < RGen::MetamodelBuilder::MMBase
# 	has_attr 'desc', String
# 	contains_many_uni 'subtasks', Task
# end


# TODO Create a REAL EClass and instantiate one object, then serialize it


class TestEmfJsonserNav < Test::Unit::TestCase

	def test_rel_conts_contains_relcont
		#t1 = Task.build 'something to do'
		#EMF::JsonSerialization::
	end

	def test_rel_conts_does_not_contain_non_relcont

	end

end