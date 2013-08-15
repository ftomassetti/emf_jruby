# Generic utilities related to real EMF objects

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

	def self.create_ereference
		EcoreFactory.eINSTANCE.createEReference
	end

	def self.create_eobject(eclass)
		DynamicEObjectImpl.new eclass
	end

end