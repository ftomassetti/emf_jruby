java_import org.eclipse.emf.ecore.EcoreFactory
java_import org.eclipse.emf.ecore.impl.DynamicEObjectImpl
java_import org.eclipse.emf.ecore.EcorePackage

module EMF

	EcoreLiterals = JavaUtilities.get_proxy_class('org.eclipse.emf.ecore.EcorePackage$Literals')

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

	def self.rgen_to_edatatype(rgen_datatype)
		if rgen_datatype.name=='EString'
			return EcoreLiterals.ESTRING
		else
			raise "I don't know how to deal with datatype #{rgen_datatype} (name=#{rgen_datatype.name})"
		end
	end

	def self.rgen_to_eclass(rgen_class)
		emf_eclass = create_eclass
		rgen_class.ecore.getEAttributes.each do |a|			
			emf_a = create_eattribute
			emf_a.name = a.name
			emf_a.setEType(rgen_to_edatatype(a.eType))
			emf_eclass.getEStructuralFeatures.add emf_a
		end
		emf_eclass
	end

end
