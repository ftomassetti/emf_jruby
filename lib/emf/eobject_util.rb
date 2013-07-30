module EObjectUtil

	def self.all_contents(root)
		contents = []
		root.getAllContents.each {|e| contents << e}
		contents
	end

	def self.only_content_of_eclass(root,eclass)
		selected = all_contents(root).select {|o| o.eClass.isSuperTypeOf eclass}
		raise "One expected, #{selected.count} found" unless selected.count == 1
		selected.first
	end

end