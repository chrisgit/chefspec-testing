Namespaced Libraries in ChefSpec
====================

Start with a simple module

````
module MyCompany
	module Software
		def apply_config?
			not ::File.exist?('/software/configure.txt')
		end

		def install?
			not ::File.exist?('/programs/widget_software')
		end
	end
end

````

And add the methods to a Chef::Recipe and 

````
Chef::Recipe.send(:include, ::MyCompany::Software)
Chef::Resource::Package.send(:include, ::MyCompany::Software)
````

Within our cookbook we have an example where we are using the methods in Compile time
````
if apply_config?
    file '/software/configure.txt' do
        content '<settings>run_software = true</settings>'
        action :create
    end
end
````

And also converge time
````
package 'super_software' do
	source '/installers'
	action :install
    only_if { install? }
end
````

As we are changing the definition of ALL instance of Chef::Recipe and Chef::Resource::Package we can be a bit lazy with our stubbing as RSpec enables us to say "allow any instance of this class to receive this method"

````
allow_any_instance_of(Chef::Resource::Package).to receive(:install?).and_return(value)
allow_any_instance_of(Chef::Recipe).to receive(:apply_config?).and_return(value)
````

Run these tests by changing to the root folder (where this README.md file is contained) and typing RSpec, if necessary include pry and add breakpoints to step through the code.

License and Authors
-------------------
Authors: Chris Sullivan
