require 'emf_jruby'
require 'test/unit'
require 'rgen/metamodel_builder'

java_import org.eclipse.emf.ecore.EAttribute

class TestRgenNav < Test::Unit::TestCase

	Pack = EMF.create_epackage('my_pack','my_pack_uri')

	Person = EMF.create_eclass Pack
	Person.eStructuralFeatures.add EMF.create_eattribute_str('name')

	Task = EMF.create_eclass Pack
	Task.eStructuralFeatures.add EMF.create_eattribute_str('desc')

	Project = EMF.create_eclass Pack
	Project.eStructuralFeatures.add EMF.create_ereference(Task,'tasks',[:many,:containment])
	Project.eStructuralFeatures.add EMF.create_ereference(Person,'personnel',[:many,:containment])
	Project.eStructuralFeatures.add EMF.create_ereference(Task,'related_tasks',[:many,:not_containment])

	RecThing = EMF.create_eclass Pack
	RecThing.eStructuralFeatures.add EMF.create_eattribute_str('desc')
	RecThing.eStructuralFeatures.add EMF.create_ereference(RecThing,'inside',[:many,:containment])

	def project
	 	EMF.create_eobject(Project)
	end

	def task(desc)
	 	t = EMF.create_eobject(Task)
	 	t.set_attr_value 'desc', desc
	 	t
	end

	def recthing(str)
		p = EMF.create_eobject(RecThing)
		p.set_attr_value 'desc', str
		p
	end

	def person(name)
		p = EMF.create_eobject(Person)
		p.set_attr_value 'name', name
		p
	end

	def test_get_attr_existing
		t = EMF.create_eobject(Task)
		a = t.get_attr 'desc'
		assert a.is_a? EAttribute
		assert_equal 'desc', a.name
	end

	def test_get_attr_unexisting
		t = EMF.create_eobject(Task)
		a = t.get_attr 'name'
		assert_equal nil,a
	end

	def test_set_attr_value
		t = EMF.create_eobject(Task)
		t.set_attr_value 'desc', 'my desc'
		a = t.get_attr 'desc'
		v = t.eGet a
		assert_equal 'my desc',v
	end

	def test_get_attr_value
		t = EMF.create_eobject(Task)
		t.set_attr_value 'desc', 'my desc'
		assert_equal 'my desc',t.get_attr_value('desc')
	end

	def test_only_child_of_eclass_zero_found
		p = project
		t = task "related task"
		p.add_to_ref 'related_tasks', t # it is a referenced but not contained task
		assert_raise EMF::LessThanExpectedFound do
			p.only_child_of_eclass(Person)
		end
		assert_raise EMF::LessThanExpectedFound do
			p.only_child_of_eclass(Task)
		end
	end

	def test_get_ref
		p = project
		t = p.get_ref 'tasks'
		assert_equal 'tasks',t.name
		assert_equal Task, t.etype
	end

	def test_only_child_of_eclass_one_found
		pr = project
		t1 = task "task 1"
		t2 = task "task 2"
		p1 = person "a person"
		pr.add_to_ref 'tasks', t1
		pr.add_to_ref 'tasks', t2
		pr.add_to_ref 'personnel', p1
		assert p1.equal? pr.only_child_of_eclass(Person)
	end

	def test_only_child_of_eclass_many_found
		pr = project
		t1 = task "task 1"
		t2 = task "task 2"
		p1 = person "a person"
		pr.add_to_ref 'tasks', t1
		pr.add_to_ref 'tasks', t2
		pr.add_to_ref 'personnel', p1
		assert_raise EMF::MoreThanExpectedFound do 
			pr.only_child_of_eclass(Task)
		end
	end

	def test_resource_children
		res = Java::OrgEclipseEmfEcoreResourceImpl::ResourceImpl.new
		a = recthing('a')
		b = recthing('a>b')
		c = recthing('a>c')
		d = recthing('a>b>d')
		e = recthing('a>b>e')
		f = recthing('a>c>f')
		g = recthing('a>c>f>g')
		a.add_to_ref 'inside', b
		a.add_to_ref 'inside', c
		b.add_to_ref 'inside', d
		b.add_to_ref 'inside', e
		c.add_to_ref 'inside', f
		f.add_to_ref 'inside', g

		res.children.add a

		assert_equal [a], res.children.entries
	end

	def test_resource_children_deep
		res = Java::OrgEclipseEmfEcoreResourceImpl::ResourceImpl.new
		a = recthing('a')
		b = recthing('a>b')
		c = recthing('a>c')
		d = recthing('a>b>d')
		e = recthing('a>b>e')
		f = recthing('a>c>f')
		g = recthing('a>c>f>g')
		a.add_to_ref 'inside', b
		a.add_to_ref 'inside', c
		b.add_to_ref 'inside', d
		b.add_to_ref 'inside', e
		c.add_to_ref 'inside', f
		f.add_to_ref 'inside', g

		res.children.add a

		assert_equal [a,b,d,e,c,f,g], res.children_deep.entries
	end

	def test_eobjects_children
		a = recthing('a')
		b = recthing('a>b')
		c = recthing('a>c')
		d = recthing('a>b>d')
		e = recthing('a>b>e')
		f = recthing('a>c>f')
		g = recthing('a>c>f>g')
		a.add_to_ref 'inside', b
		a.add_to_ref 'inside', c
		b.add_to_ref 'inside', d
		b.add_to_ref 'inside', e
		c.add_to_ref 'inside', f
		f.add_to_ref 'inside', g

		assert_equal [],d.children.entries
		assert_equal [],e.children.entries
		assert_equal [],g.children.entries
		assert_equal [g],f.children.entries
		assert_equal [d,e],b.children.entries
		assert_equal [f],c.children.entries
		assert_equal [b,c],a.children.entries
	end

	def test_eobjects_children_deep
		a = recthing('a')
		b = recthing('a>b')
		c = recthing('a>c')
		d = recthing('a>b>d')
		e = recthing('a>b>e')
		f = recthing('a>c>f')
		g = recthing('a>c>f>g')
		a.add_to_ref 'inside', b
		a.add_to_ref 'inside', c
		b.add_to_ref 'inside', d
		b.add_to_ref 'inside', e
		c.add_to_ref 'inside', f
		f.add_to_ref 'inside', g

		assert_equal [],d.children_deep.entries
		assert_equal [],e.children_deep.entries
		assert_equal [],g.children_deep.entries
		assert_equal [g],f.children_deep.entries
		assert_equal [d,e],b.children_deep.entries
		assert_equal [f,g],c.children_deep.entries
		assert_equal [b,d,e,c,f,g],a.children_deep.entries
	end

end
