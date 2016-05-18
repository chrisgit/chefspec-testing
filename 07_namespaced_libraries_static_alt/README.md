Namespaced Library with Static methods Alternative
==================================================
(Cont.)

We saw previously that our module with a static method wasn't so easy to test when the method is used in Chef's compile phase, this was because the Cookbook compiler uses Ruby's "load" to read the library methods into memory; thereby losing any RSpec stubbing. 

The solution was to stop the definition being interpreted by
* Stopping the module from being re-evaluated
* Monkey patching the cookbook compiler to avoid re-loading the library

There is another option but the code required to impliment it is quite obtuse.

Often a single static method can be used as a basic factory method, therefore in theory rather than stop our Module or Class definition reloading we can change the code so that the static method instantiates a Class that will carry out the work for us. If we use a factory method it could instantiate and call a method on the real instance for production and a dummy class for testing. 

In the example here though we aren't using any factories but working on the basis of
* RSpec can stub a method on a class
* If a new class definition is loaded that does not contain a new definition of the stubbed method then we will not override RSpecs stub method

In principal this works the same way that stubbing a non namespaced method in Chef::Recipe works, the Chef::Recipe can call the methods you write in your libraries because they are added to Object class, you are not re-defining or opening the Chef::Recipe class. 

1. Write a class that will impliment our code
````
class Configuration
	def apply_config?
		not ::File.exist?('/software/configure.txt')
	end
	
	def install?
		not ::File.exist?('/programs/widget_software')
	end
end
````

2. Write a class that inherits our implimentation so that we can stub
````
class SoftwareConfiguration < Configuration
end 
````

3. Modify the module or class with the static to use the inherited class
````
module MyCompany
	module Software
		def self.apply_config?
			SoftwareConfiguration.new().apply_config?		
		end

		def self.install?
			SoftwareConfiguration.new().install?
		end
	end
end
````

4. Ensure the class constants are available for your tests; in your RSpec/ChefSpec tests either load the library or declare the constants
````
# Load your library or declare your classes otherwise Constant not exists
#require_relative '../../libraries/helper' 

class Configuration; end
class SoftwareConfiguration < Configuration; end
```` 

5. Stub the "empty" class
````
    context 'when software not installed' do
        it 'should install and configure software' do
            allow_any_instance_of(SoftwareConfiguration).to receive(:apply_config?).and_return(true)
            
            chef_run = chef_instance.converge(described_recipe) do
                allow_any_instance_of(SoftwareConfiguration).to receive(:install?).and_return(true)
            end
            
            expect(chef_run).to install_package('super_software')
            expect(chef_run).to create_file('/software/configure.txt')
       end
    end
````


License and Authors
-------------------
Authors: Chris Sullivan
