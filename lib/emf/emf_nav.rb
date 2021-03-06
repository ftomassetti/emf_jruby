# Utils methods to naviate real EMF objects

java_import org.eclipse.emf.ecore.EObject
java_import org.eclipse.emf.ecore.util.EContentsEList
java_import org.eclipse.emf.common.util.BasicEList

module Java::OrgEclipseEmfEcore::EObject

	module NavigationMethods

		def children
			method = nil
			method = :eContents if respond_to?(:eContents)
			method = :old_contents if respond_to?(:old_contents)	
			method = :getContents if respond_to?(:getContents)
			raise "No method for getting contents, class: #{self.class}" unless method!=nil
			res = (send method)
			obj = self
			res
		end

		def children_deep
			l = []
			children.each do |c|
				l << c
				begin
					grand_children = c.children_deep
				rescue Exception => e
					raise "Problem getting children of #{c} (#{c.class}): #{e}"
				end
				grand_children.each do |sc|
					l << sc
				end
			end   
			l
		end

		def only_child_of_eclass(eclass)
			Java::OrgEclipseEmfEcore::EObject::NavigationMethods.only_of_class(children,eclass)
		end

		def only_child_deep_of_eclass(eclass)
			Java::OrgEclipseEmfEcore::EObject::NavigationMethods.only_of_class(children_deep,eclass)
		end

		def self.only_of_class(collection,eclass)
			selected = collection.select {|o| o.eClass.isSuperTypeOf eclass}
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

		def set_ref_value(ref_name,value)
			r = get_ref(ref_name)
			raise 'Ref not found' unless r
			eSet(r,value)
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

class Java::OrgEclipseEmfEcoreImpl::BasicEObjectImpl

	include Java::OrgEclipseEmfEcore::EObject::NavigationMethods
	include Java::OrgEclipseEmfEcore::EObject::ModificationMethods

end

class Java::OrgEclipseEmfEcoreResourceImpl::ResourceImpl

	include Java::OrgEclipseEmfEcore::EObject::NavigationMethods

end