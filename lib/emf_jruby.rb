curr_dir = File.dirname(__FILE__)
Dir[curr_dir+"/jars/*.jar"].each do |jar|
	require jar
end

Dir[curr_dir+"/emf/*.rb"].each do |rb|
	require rb
end
