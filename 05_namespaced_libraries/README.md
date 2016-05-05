Namespaced Libraries
====================

The code in namespaced libraries are not automatically available to a Chef::Recipe or Chef::Resource, we need to explicitly add the code to Chef::Recipe and Chef::Resource.

To understand why this is it is probably easier to revert to an example in Ruby.

Given a basic module with a method that performs an add function, we want to include those methods in a basic class.

````
module CompanyA
	module BasicMath
		def add(n1,n2)
			n1+n2
		end
	end
end

class Stuff
	include CompanyA::BasicMath
end

x = Stuff.new
puts x.add(1,3) #=> 4
````

The above example we have written and declared the Stuff class and included our BasicMath module which contains our add method. 

All classes (and modules) in Ruby are open for extension so even if someone else had written BasicMath module or the Stuff class we could simply open the module or class and make the changes.   

What if we wanted to add extra behavior to a class without explicitly opening it and modifying the definition? 

In Ruby (and other OO languages) the objects talk to each other in terms of messages, in Ruby one object can talk to another using the send method; therefore we can send a message to an objects include method.

````
module CompanyA
	module BasicMath
		def add(n1,n2)
			n1+n2
		end
	end
end

class Stuff; end

Stuff.send(:include, CompanyA::BasicMath)
x = Stuff.new
puts x.add(1,3)
````

What we are doing is changing the definition of the Stuff class, therefore all and any existing instances of the Stuff class will have our new functionality

````
module CompanyA
	module BasicMath
		def add(n1,n2)
			n1+n2
		end
	end
end

class Stuff; end
# Create a new instance of stuff ... no add methods
x = Stuff.new
# Extend the class definition
Stuff.send(:include, CompanyA::BasicMath)
puts x.add(1,3)
````

However you can simply modify a single instance of a class with your module using the extend method.

````
module CompanyA
	module BasicMath
		def add(n1,n2)
			n1+n2
		end
	end
end

class Stuff; end
x = Stuff.new
x.extend(CompanyA::BasicMath) #=> Modify just this instance of Stuff
puts x.add(1,3)

y = Stuff.new
puts y.add(1,4) #=> include_module.rb:21:in `<main>': undefined method `add' for #<Stuff:0x2abe6b0> (NoMethodError)
````

In terms of Chef code, we normally see the send method being used to add our namespaces methods similar to the code below

````
Chef::Recipe.send(:include, ::MyCompany::QueryEnvironment) #=> Extend Chef::Recipe
Chef::Resource::Log.send(:include, ::MyCompany::QueryEnvironment) #=> Extend Chef::Resource::Log
````
This example is for testing namespaced library code only, what we have done is stub out the calls to Chef's shellout method.

The example does not require Chefspec.

Run these tests by changing to the root folder (where this README.md file is contained) and typing RSpec, if necessary include pry and add breakpoints to step through the code.

License and Authors
-------------------
Authors: NVM Automation team
