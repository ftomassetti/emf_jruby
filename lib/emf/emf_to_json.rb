require 'ast_serialization'

def qname(e_object)
	e_class = e_object.eClass
	e_package = e_class.ePackage
	"#{e_package.nsURI}##{e_class.name}"
end

def jsonize_attr_value(map,e_object,e_attr)
	value = e_object.eGet e_attr
	if e_attr.upperBound==1
		map["attr_#{e_attr.name}"] = value
	else
		l = []
		(0..(value.size-1)).each do |i|
			l << value.get(i)
		end
		map["attr_#{e_attr.name}"] = l
	end
end

def jsonize_ref_single_el(single_value,containment,adapters)
	if containment
		jsonize_obj(single_value,adapters)
	else
		serialization_id(single_value)
	end
end

def jsonize_ref_value(map,e_object,e_ref,adapters)
	value = e_object.eGet e_ref

	propname = "relcont_#{e_ref.name}" if e_ref.containment
	propname = "relnoncont_#{e_ref.name}" if not e_ref.containment

	if e_ref.upperBound==1		
		map[propname] = jsonize_ref_single_el(value,e_ref.containment,adapters)
	else
		l = []
		(0..(value.size-1)).each do |i|
			l << jsonize_ref_single_el(value.get(i),e_ref.containment,adapters)
		end
		map[propname] = l
	end
end

def jsonize_obj(e_object, adapters={})
	if not e_object
		nil
	else 
		map = { 'type' => qname(e_object), 'id' => serialization_id(e_object) }
		e_class = e_object.eClass
		e_class.eAllAttributes.each do |a|		
			jsonize_attr_value(map,e_object,a)
		end
		e_class.eAllReferences.each do |r|
			#puts "ref #{r.name} #{r.containment}"
			jsonize_ref_value(map,e_object,r,adapters)
		end
		if adapters.has_key? qname(e_object)
			adapters[qname(e_object)].adapt(e_object,map)
		end
		map
	end
end