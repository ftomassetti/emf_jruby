require 'emf_jruby'
require 'test/unit'
require 'rgen/metamodel_builder'

java_import org.eclipse.emf.ecore.EAttribute

class TestRgenNav < Test::Unit::TestCase

	class Person < RGen::MetamodelBuilder::MMBase
		has_attr 'name', String
	end

	class Task < RGen::MetamodelBuilder::MMBase
		has_attr 'desc', String
	end

	class Project < RGen::MetamodelBuilder::MMBase
		contains_many 'tasks', Task, 'project'
		contains_many 'personnel', Person, 'work'
		has_many 'related_tasks', Task
	end

	PersonEClass = Person.to_eclass
	TaskEClass = Task.to_eclass
	ProjectEClass = Project.to_eclass

	def project
		EMF.create_eobject(ProjectEClass)
	end

	def task(desc)
		t = EMF.create_eobject(TaskEClass)
		t.set_attr_value 'desc', desc
		t
	end

	def person(name)
		p = EMF.create_person(PersonEClass)
		p.set_attr_value 'name', name
		p
	end

	def test_get_attr_existing
		t = EMF.create_eobject(TaskEClass)
		a = t.get_attr 'desc'
		assert a.is_a? EAttribute
		assert_equal 'desc', a.name
	end

	def test_get_attr_unexisting
		t = EMF.create_eobject(TaskEClass)
		a = t.get_attr 'name'
		assert_equal nil,a
	end

	def test_set_attr_value
		t = EMF.create_eobject(TaskEClass)
		t.set_attr_value 'desc', 'my desc'
		a = t.get_attr 'desc'
		v = t.eGet a
		assert_equal 'my desc',v
	end

	def test_get_attr_value
		t = EMF.create_eobject(TaskEClass)
		t.set_attr_value 'desc', 'my desc'
		assert_equal 'my desc',t.get_attr_value('desc')
	end

	def test_only_content_of_eclass_zero_found
		p = project
		t = task "related task"
		p.related_tasks << t # it is a referenced but not contained task
		assert_raise EMF::LessThanExpectedFound do
			p.only_content_of_eclass(Person)
		end
		assert_raise EMF::LessThanExpectedFound do
			p.only_content_of_eclass(Task)
		end
	end

	def test_only_content_of_eclass_one_found
		pr = project
		t1 = task "task 1"
		t2 = task "task 2"
		p1 = person "a person"
		pr.tasks << t1
		pr.tasks << t2
		pr.personnel << p1
		assert p1.equal? pr.only_content_of_eclass(Person)
	end


	def test_only_content_of_eclass_many_found
		pr = project
		t1 = task "task 1"
		t2 = task "task 2"
		p1 = person "a person"
		pr.tasks << t1
		pr.tasks << t2
		pr.personnel << p1
		assert_raise EMF::MoreThanExpectedFound do 
			pr.only_content_of_eclass(Task)
		end
	end

end
