require 'json'
require 'fileutils'
require 'lightmodels'

module EMF

module Serialization

class << self
	include LightModels::Serialization
end

def self.qname(e_object)
	if e_object.respond_to? :eClass 
		e_class = e_object.eClass
		e_package = e_class.ePackage
		"#{e_package.nsURI}##{e_class.name}"
	else
		raise "Error"
	end
end

def self.eobject_to_model(root,adapters={})
	@serialization_ids = {}
	@next_serialization_id = 1

	model = {}
	external_elements = if root.eResource
		root.eResource.contents.select {|e| e!=root}
	else
		[]
	end

	model['root'] = LightModels::Serialization.jsonize_obj(root,adapters)
	model['external_elements'] = []
	external_elements.each do |ee|
		model['external_elements'] << LightModels::Serialization.jsonize_obj(ee)
	end
	model
end

end

end