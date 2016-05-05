Namespaced Library with Static methods
======================================

When you write a static method (singleton) in a module or class in Ruby you can call that method directly, see below

````
module CompanyA
	module BasicMath
		def self.add(n1,n2) #=> Can also write the signature as def BasicMath.add(n1,n2) but prefixing with self is recomended
			n1+n2
		end
	end
end

puts CompanyA::BasicMath.add(1, 3)
````  

It is very easy to use a static method from your libraries code and use it in Chef recipe but it is not so easy to test.

Say we have a module with a static method in our library file

````
module MyCompany
	module Software
		def self.apply_config?
			not ::File.exist?('/software/configure.txt')
		end

		def self.install?
			not ::File.exist?('/programs/widget_software')
		end
	end
end
````

We can use this in a recipe at compile or converge time by simply calling the method we want

````
MyCompany::Software.install?
````

Testing with ChefSpec
---------------------

Before we created some module methods and added those to Chef::Recipe and Chef::Resource::Package then stubbed out any instance of those classes.

What we need to do here is stub out our static library method.

However if you stub your statuc library method in the before block 
````
before do
  allow(MyCompany::Software).to receive(:install?).and_return(false) 
end
````
or it block
````
it 'should install and configure software' do
  allow(MyCompany::Software).to receive(:install?).and_return(false) 
````

You will get an uninitialized constant message
````
     Failure/Error: allow(MyCompany::Software).to receive(:install?).and_return(false)
     NameError:  uninitialized constant MyCompany
````

This is because ChefSpec has not run and therefore Chef has not loaded your library file, hence constant undefined, we are stubbing something that has not been loaded.

What we can do is either declare a mock/fake for the module in the spec file (or spec helper) and then stub that, the fake can be very basic, it doesn't need the actual methods we will call as we'll stub those

````
module MyCompany
    module Software
    end
end
...
before do
  allow(MyCompany::Software).to receive(:install?).and_return(false) 
end
````

This gets us past the uninitialised constant error but the tests will fail! Why?

When Chef has loaded our library file a new definition of the MyCompany::Software module is loaded into memory replacing the fake in our test files.
More importantly the loaded module isn't the one we stubbed!

So how do we fix this?

If your static method is called in the converge phase you can use a hook in ChefSpec that will execute a block between compile and converge phase

````
chef_run = chef_instance.converge(described_recipe) do
    allow(MyCompany::Software).to receive(:install?).and_return(false)
end
expect(chef_run).to_not install_package('super_software')
```` 

However, it's not so easy to stub out a static method that is used in the compile phase.

This ticket has probably the best solution https://github.com/sethvargo/chefspec/issues/562

Solutions are
* load library files in our test code and monkey patch the load_libraries_from_cookbook method in the cookbook compiler to do nothing or ignore certain library files
* stop the module being re-evaluated if it has already been declared

The issue ticket suggests the latter solution which can be done by adding an unless defined? (or Module.const_defined?("ModA::ModB")) to the declaration of your module.

The module becomes
````
module MyCompany
	module Software
		def self.apply_config?
			not ::File.exist?('/software/configure.txt')
		end

		def self.install?
			not ::File.exist?('/programs/widget_software')
		end
	end
end unless defined?(MyCompany::Software) #=> When unit testing the cookbook we have defined the constants and stubbed, hence do no overwrite
````

Run these tests by changing to the root folder (where this README.md file is contained) and typing RSpec, if necessary include pry and add breakpoints to step through the code.

License and Authors
-------------------
Authors: Chris Sullivan
