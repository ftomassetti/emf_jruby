emf_libs = $:.select{|e| e.gsub('emf_jruby').count>0}
raise "One lib containing 'emf_jruby' expected, found: #{emf_libs}" unless emf_libs.count==1

Dir[emf_libs[0]+"/jars/*.jar"].each do |jar|
end