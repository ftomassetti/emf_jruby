require 'emf_jruby'

java_import org.eclipse.emf.ecore.EcoreFactory
java_import org.eclipse.emf.ecore.impl.DynamicEObjectImpl

module EMF

	def self.create_eclass
		EcoreFactory.eINSTANCE.createEClass
	end

	def self.create_eobject(eclass)
		DynamicEObjectImpl.new eclass
	end

	def self.rgen_to_eobject(rgen_obj)
	end

	def self.rgen_to_eclass(rgen_class)
		raise "MMBase expected, #{rgen_class.ancestors}" unless rgen_class.is_a? RGen::MetamodelBuilder::MMBase
	end

end

require 'rgen/metamodel_builder'

module RubyMM

	class Value < RGen::MetamodelBuilder::MMBase
	end

	class Block < Value
		has_many 'contents', Value
	end 

	class Call < Value
		has_attr 'name', String
		has_many 'args', Value
		has_one 'receiver', Value
	end

	class Def < RGen::MetamodelBuilder::MMBase
		has_attr 'name', String
		has_one 'body', Value
	end

	class Literal < Value
	end

	class IntLiteral < Literal
		has_attr 'value', Integer
	end

end

# I should catch the 'has_attr', 'has_many' and use them to prepare the eclass

my_eclass = EMF.create_eclass
my_eclass.name = 'MyEclass'

my_eo = EMF.create_eobject my_eclass

EMF.rgen_to_eclass(RubyMM::IntLiteral)