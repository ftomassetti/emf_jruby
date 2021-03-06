require 'test/unit'
require 'emf_jruby'
require 'lightmodels'

class TestMisc < Test::Unit::TestCase

	EcoreLiterals = JavaUtilities.get_proxy_class('org.eclipse.emf.ecore.EcorePackage$Literals')

	Pack = EMF.create_epackage('my_pack','my_pack_uri')

	Person = EMF.create_eclass Pack
	Person.eStructuralFeatures.add EMF.create_eattribute_str('name')

	Address = EMF.create_eclass Pack
	Address.eStructuralFeatures.add EMF.create_eattribute_str('street')
	Address.eStructuralFeatures.add EMF.create_eattribute('number',EcoreLiterals::ELONG)

	Person.eStructuralFeatures.add EMF.create_ereference(Address, 'home_address', [:containment])

	def test_rel_conts_on_simple_node
		federico = EMF.create_eobject(Person)
		lm = EMF::Serialization.eobject_to_model(federico)['root']
		assert_equal 1,LightModels::QuerySerialized.rel_conts(lm).count
		assert_equal 'relcont_home_address',LightModels::QuerySerialized.rel_conts(lm)[0]
	end	

	EcoreLiterals = JavaUtilities.get_proxy_class('org.eclipse.emf.ecore.EcorePackage$Literals')

	Pack = EMF.create_epackage('my_pack','my_pack_uri')

	Person = EMF.create_eclass Pack
	Person.eStructuralFeatures.add EMF.create_eattribute_str('name')

	Address = EMF.create_eclass Pack
	Address.eStructuralFeatures.add EMF.create_eattribute_str('street')
	Address.eStructuralFeatures.add EMF.create_eattribute('number',EcoreLiterals::ELONG)

	Person.eStructuralFeatures.add EMF.create_ereference(Address, 'home_address', [:containment])

	def test_collect_values_empty
		p = EMF.create_eobject(Person)
		m = EMF::Serialization.eobject_to_model(p)

		assert_equal 0,LightModels::QuerySerialized.collect_values(m['root']).count
	end

	def test_collect_values_single_value
		p = EMF.create_eobject(Person)
		p.set_attr_value('name','Federico')
		m = EMF::Serialization.eobject_to_model(p)

		assert_equal 1,LightModels::QuerySerialized.collect_values(m['root']).count
		assert LightModels::QuerySerialized.collect_values(m['root']).include? 'Federico'
	end

	def test_collect_values_in_children
		home = EMF.create_eobject(Address)
		home.set_attr_value 'street','via Tripoli'
		home.set_attr_value 'number',27
		federico = EMF.create_eobject(Person)
		federico.set_attr_value 'name','Federico'
		federico.set_ref_value 'home_address', home

		map = LightModels::QuerySerialized.collect_values_with_count(EMF::Serialization.eobject_to_model(federico)['root'])
		assert_equal 3,map.count
		assert_equal 1,map['via Tripoli']
		assert_equal 1,map['Federico']
		assert_equal 1,map[27]
	end

	def test_collect_values_in_children_with_count_2
		home = EMF.create_eobject(Address)
		home.set_attr_value 'street','Federico'
		home.set_attr_value 'number',27
		federico = EMF.create_eobject(Person)
		federico.set_attr_value 'name','Federico'
		federico.set_ref_value 'home_address', home

		map = LightModels::QuerySerialized.collect_values_with_count(EMF::Serialization.eobject_to_model(federico)['root'])
		assert_equal 2,map.count
		assert_equal 2,map['Federico']
		assert_equal 1,map[27]
	end

	def test_collect_values_in_children_with_count_on_complex_object
		set_completed = JSON.parse(IO.read(File.dirname(__FILE__)+'/data/node_setCompleted.json'))

		map = LightModels::QuerySerialized.collect_values_with_count(set_completed)
		assert_equal 4,map.count
		assert_equal 1,map['completed']
		assert_equal 1,map[true]
		assert_equal 1,map[false]
		assert_equal 1,map['setCompleted']
	end

end

class TestSerializationEmf < Test::Unit::TestCase

	Pack = EMF.create_epackage('my_pack','my_pack_uri')

	Person = EMF.create_eclass Pack
	Person.eStructuralFeatures.add EMF.create_eattribute_str('name')

	def test_to_model_with_single_obj
		p = EMF.create_eobject(Person)
		m = EMF::Serialization.eobject_to_model(p)

		assert_equal 1,m['root']['id']
		assert_equal 0,m['external_elements'].count
	end

end