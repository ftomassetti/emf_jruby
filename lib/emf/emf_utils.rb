# Generic utilities related to real EMF objects

java_import org.eclipse.emf.ecore.EcoreFactory
java_import org.eclipse.emf.ecore.impl.DynamicEObjectImpl
java_import org.eclipse.emf.ecore.EcorePackage

module EMF

	EcoreLiterals = JavaUtilities.get_proxy_class('org.eclipse.emf.ecore.EcorePackage$Literals')

	def self.create_eclass(p=nil)
		if p
			c = p.createEClass p.next_id
			c
		else
			EcoreFactory.eINSTANCE.createEClass
		end
	end

	def self.create_eattribute(name, datatype)
		a = EcoreFactory.eINSTANCE.createEAttribute
		a.name = name
		a.etype = datatype
		a
	end

	def self.create_eattribute_str(name)
		create_eattribute(name,EcoreLiterals::ESTRING)
	end

	def self.create_ereference(type=nil, name=nil, params=[])
		r = EcoreFactory.eINSTANCE.createEReference #(type, type.ePackage.next_id)
		r.set_etype(type) 
		r.name = name
		raise 'Cannot be both single and many' if params.include? :many and params.include? :single
		raise 'Cannot be both containment and not containment' if params.include? :containment and params.include? :not_containment
		containment = params.include? :containment
		many = params.include? :many
		r.containment = containment
		r.set_upper_bound(-1) if many
		r.set_upper_bound(1) unless many
		r
	end

	def self.create_eobject(eclass)
		eo = EcoreFactory.eINSTANCE.createEObject
		eo.eSetClass eclass
		eo
	end

	def self.create_epackage(name, uri)
		p = EcoreFactory.eINSTANCE.createEPackage
		class << p
			def next_id
				@next_id = 0 unless @next_id
				@next_id += 1
				@next_id
			end
		end
		p.setName name
		p.setNsURI uri
		p
	end

end