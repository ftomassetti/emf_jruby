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
		rgen_class.ecore.eGet...
	end

end
