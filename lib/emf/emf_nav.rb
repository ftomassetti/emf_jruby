# Utils methods to naviate real EMF objects

java_import org.eclipse.emf.ecore.EObject

module Java::OrgEclipseEmfEcore::EObject

	module NavigationMethods
		
		def only_content_of_eclass(eclass)
			selected = eAllContents.select {|o| o.eClass.isSuperTypeOf eclass}
			case selected.count
			when 0
				raise EMF::LessThanExpectedFound.new
			when 1
				return selected.first
			else
				raise EMF::MoreThanExpectedFound.new
			end
		end

	end

	module ModificationMethods

		def set_attr_value(attr_name,value)
			a = get_attr(attr_name)
			raise 'Attr not found' unless a
			eSet(a,value)
		end

		def get_attr_value(attr_name)
			eGet(get_attr(attr_name))
		end

		def get_attr(attr_name)
			(eClass.getEAllAttributes.select {|a| a.name==attr_name}).first
		end

		def get_ref(name)
			(eClass.getEAllReferences.select {|r| r.name==name}).first
		end

		def get_ref_value(name)
			eGet(get_ref(name))
		end

		def add_to_ref(ref_name,el)
			l = eGet(get_ref(ref_name))
			l.add el
		end

	end

	include NavigationMethods
	include ModificationMethods

end

class Java::OrgEclipseEmfEcoreImpl::EObjectImpl

	include Java::OrgEclipseEmfEcore::EObject::NavigationMethods
	include Java::OrgEclipseEmfEcore::EObject::ModificationMethods

end