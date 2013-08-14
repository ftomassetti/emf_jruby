java_import org.eclipse.emf.ecore.EcoreFactory
java_import org.eclipse.emf.ecore.impl.DynamicEObjectImpl
java_import org.eclipse.emf.ecore.EcorePackage

# TODO: separate in RGen and EMF

module EMF

	# Track already converted classes
	# Known the namespace and the URI
	class ConversionContext
		def initialize
			@classes_cache = {}
		end

		def convert(rgen_class)
			unless @classes_cache[rgen_class]
				emf_class = EMF.rgen_to_eclass(rgen_class,self)
				@classes_cache[rgen_class] = emf_class
			end
			@classes_cache[rgen_class]
		end
	end

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

	def self.rgen_to_eobject(rgen_obj)
	end

	def self.rgen_to_edatatype(rgen_datatype)
		if rgen_datatype.name=='EString'
			return EcoreLiterals.ESTRING
		else
			raise "I don't know how to deal with datatype #{rgen_datatype} (name=#{rgen_datatype.name})"
		end
	end

	def self.rgen_to_eclass(rgen_class,context=ConversionContext.new)
		if rgen_class.respond_to? :ecore
			ecore = rgen_class.ecore
		else
			ecore = rgen_class
		end
		emf_eclass = create_eclass
		ecore.getEAttributes.each do |a|			
			emf_a = create_eattribute
			emf_a.name = a.name
			emf_a.setEType(rgen_to_edatatype(a.eType))
			emf_eclass.getEStructuralFeatures.add emf_a
		end
		ecore.getEReferences.each do |r|
			#puts "Ref #{r} #{r.name}"
			emf_r = create_ereference
			emf_r.name = r.name
			emf_r.containment = r.containment
			#emf_r.resolve_proxies = r.getResolveProxies
			#emf_r.setEType(context.convert r.getEType)
			emf_eclass.getEStructuralFeatures.add emf_r
		end
		emf_eclass
	end

end
