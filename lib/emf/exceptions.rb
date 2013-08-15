# Various exceptions used in the lib

module EMF

	class MoreThanExpectedFound < Exception
	end

	class LessThanExpectedFound < Exception
	end

	class UnexistingFeature < Exception
		attr_reader :feat_name
		def initialize(feat_name)
			@feat_name = feat_name
		end
		def to_s
			"UnexistingFeature: '#{@feat_name}'"
		end
	end

	class SingleAttributeRequired < Exception
		def initialize(class_name,attributes)
			@class_name = class_name
			@attributes = attributes
		end
		def to_s
			names = []
			@attributes.each {|a| names << a.name}
			"SingleAttributeRequired: '#{@class_name}', attributes: #{names.join(', ')}"
		end
	end

end