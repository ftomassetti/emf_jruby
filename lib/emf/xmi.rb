# Methods to managa XMI serialization of real EMF objects

require 'rgen/metamodel_builder'

java_import org.eclipse.emf.ecore.resource.ResourceSet
java_import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl
java_import org.eclipse.emf.ecore.xmi.impl.XMIResourceImpl
java_import org.eclipse.emf.ecore.EObject
java_import org.eclipse.emf.ecore.resource.Resource

module EMF	

	module XmiConversion

		def self.to_xmi(data)
			if data.is_a? EObject
				eobject_to_xmi(data)			
			elsif data.is_a? Resource
				resource_to_xmi(data)
			else
				raise "I do not know how to save a #{data.class}"
			end
		end

		def self.eobject_to_xmi(eobject)
			resource_set = ResourceSetImpl.new 
			resource = XMIResourceImpl.new
			resource_set.resources.add resource
			resource.contents.add eobject
			to_xmi(resource)
		end

		def self.resource_to_xmi(res)
			writer = java.io.StringWriter.new
			res.save(writer,nil)
			writer.to_s
		end

	end

	class Java::OrgEclipseEmfEcoreImpl::BasicEObjectImpl

		module XmiMethods

			def to_xmi
				EMF::XmiConversion::eobject_to_xmi(self)			
			end

		end

		include XmiMethods

	end

end