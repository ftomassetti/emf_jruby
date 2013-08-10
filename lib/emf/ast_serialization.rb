module EMF

@serialization_ids = {}
@next_serialization_id = 1

def serialization_id(obj)
	unless $serialization_ids[obj]		
		$serialization_ids[obj] = $next_serialization_id
		$next_serialization_id += 1
	end
	$serialization_ids[obj]
end

end