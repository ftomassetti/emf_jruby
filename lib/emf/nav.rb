class RGen::MetamodelBuilder::MMBase

	module NavigationMethods
		
		def only_content_of_eclass(eclass)
			selected = getAllContents.select {|o| o.eClass.isSuperTypeOf eclass}
			raise "One expected, #{selected.count} found" unless selected.count == 1
			selected.first
		end

	end

	include NavigationMethods

end