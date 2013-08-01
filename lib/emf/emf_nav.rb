module JSON
	def self.load_file(path,max_nesting=100)
		parse(File.read(path),{max_nesting: max_nesting})
	end
end

# This module permits to manipulate EObjects serialized
# as Hash
module EMF

	def self.rel_conts(root)
		root.keys.select {|k| k.start_with? 'relcont_'}
	end

	def self.rel_non_conts(root)
		root.keys.select {|k| k.start_with? 'relcont_'}
	end

	def self.attrs(root)
		root.keys.select {|k| k.start_with? 'attr_'}
	end

	def self.values(root,feat)
		raw = root[feat]
		return raw if raw.is_a? Array
		return [raw]
	end

	def self.traverse(root,depth=0,&op)
		op.call(root,depth)
		return unless root
		rel_conts(root).each do |r|
			if root[r].is_a? Array
				root[r].each do |c|
					raise "expected an object but it is a #{c.class} (relation: #{r})" unless c.is_a? Hash
					traverse(c,depth+1,&op)
				end
			else
				traverse(root[r],depth+1,&op)
			end
		end
	end

	def self.print_tree(root,depth=0)
		traverse(root) do |n,d|
			s = ""
			d.times { s = s + "  " }
			s = s + n['type'] if n
			s = s + '<NIL>' unless n
			puts s
		end
	end

end