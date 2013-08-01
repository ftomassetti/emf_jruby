# java_import org.eclipse.emf.ecore.resource.URIConverter
java_import org.eclipse.emf.ecore.resource.ResourceSet
java_import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl
java_import org.eclipse.emf.ecore.xmi.impl.XMIResourceFactoryImpl
# java_import import org.eclipse.emf.common.util.URI
java_import org.eclipse.emf.ecore.xmi.impl.XMIResourceImpl
java_import org.eclipse.emf.ecore.EObject
java_import org.eclipse.emf.ecore.resource.Resource

module EMF	

	def self.to_xmi_str(data)
		if data.is_a? EObject
			resource_set = ResourceSetImpl.new 
			resource = XMIResourceImpl.new
			resource_set.resources.add resource
			resource.contents.add e_object
			to_xmi_str(resource)			
		elsif data.is_a? Resource
			writer = java.io.StringWriter.new
			data.save(writer,nil)
			writer.to_s
		else
			raise "I do not know how to save a #{data.class}"
		end			
	end

end