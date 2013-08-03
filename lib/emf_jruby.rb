curr_dir = File.dirname(__FILE__)
Dir[curr_dir+"/jars/*.jar"].each do |jar|
	require jar
end

require 'emf/ast_serialization'
require 'emf/emf_to_json'
require 'emf/eobject_util'
require 'emf/model'
require 'emf/xmi'
require 'emf/stats'
require 'emf/rgen_to_emf'
