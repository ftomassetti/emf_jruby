require 'emf/emf_nav'

module CodeModels

class CountingMap

	def initialize
		@map = {}
		@sum_values = 0
	end

	def inc(key)
		@map[key] = 0 unless @map[key]
		@map[key] = @map[key]+1
		@sum_values += 1
	end

	def value(key)
		@map[key] = 0 unless @map[key]
		@map[key]
	end

	# number of times the value appeared divived by total frequency
	def p(key)
		@map[key].to_f/total_frequency.to_f
	end

	def each(&block)
		@map.each(&block)
	end

	def total_frequency
		@sum_values
	end

	def n_values
		@map.count
	end

end

def self.entropy(counting_map)
	s = 0.0	
	counting_map.each do |k,v|
		p = counting_map.p(k)
		s += p*Math.log(p)
	end
	-s
end

def idf(n,n_docs)
	Math.log(n_docs.to_f/n.to_f)
end

def combine_self(arr,&op)
	for i in 0..(arr.count-2)
		for j in (i+1)..(arr.count-1)
			op.call(arr[i],arr[j])
		end
	end
end

def combine(arr1,arr2,&op)
	arr1.each do |el1|
		arr2.each {|el2| op.call(el1,el2)}
	end
end


def self.load_models_from_dir(dir,verbose=false,max=-1)
	per_type_values_map = Hash.new do |pt_hash,pt_key|	
		pt_hash[pt_key] = Hash.new do |pa_hash,pa_key|
			pa_hash[pa_key] = CountingMap.new
		end
	end

	n = 0
	files = Dir[dir+'/**/*.json']
	files = files[0..(max-1)] if max!=-1
	files.each do |f|
		n+=1
		puts "...#{n}) #{f}" if verbose
		model = ::JSON.load_file(f,max_nesting=500)
		EMF.traverse(model) do |n|
			if n
				puts "\tnode: #{n['type']}" if verbose
				EMF.attrs(n).each do |a|
					puts "\t\tattr: #{a}" if verbose
					per_type_values_map[n['type']][a].inc(n[a])
				end
			end
		end
	end
	per_type_values_map
end

end
