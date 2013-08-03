java_import org.eclipse.emf.ecore.EcoreFactory
java_import org.eclipse.emf.ecore.impl.DynamicEObjectImpl
java_import org.eclipse.emf.ecore.EcorePackage

module EMF

	def self.create_eclass
		EcoreFactory.eINSTANCE.createEClass
	end

	def self.create_eattribute
		EcoreFactory.eINSTANCE.createEAttribute
	end

	def self.create_eobject(eclass)
		DynamicEObjectImpl.new eclass
	end

	def self.rgen_to_eobject(rgen_obj)
	end

	def self.rgen_to_eclass(rgen_class)
		emf_eclass = create_eclass
		rgen_class.ecore.getEAttributes.each do |a|
			emf_a = create_eattribute
			emf_eclass.getEStructuralFeatures.add emf_a
		end
		emf_eclass
	end

end
