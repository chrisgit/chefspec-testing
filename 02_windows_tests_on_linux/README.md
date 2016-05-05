Windows Tests On Linux
======================
We've got Windows laptops, a Windows VM, a Windows cookbook. Running ChefSpec on our laptops works fine, but what about when your CI system runs Linux?

Thankfully we can spoof our environment when running ChefSpec tests thanks to fauxhai https://github.com/customink/fauxhai

The cookbook here is fairly simple, we have a default cookbook that calls the stop_services recipe, stop_services will stop the nxlog service if it is installed.

ChefSpec will load resources and then converge them up to the point of carrying out actions and no more.

As previously mentioned the ChefSpec documentation is excellent so I won't go into too much detail about how to use ChefSpec.

In this example we are using the ChefSpec::SoloRunner, my preference is to declare two methods, one to return the chef runner instance, the other to use the chef runner and perform a converge.

````
	let(:chef_instance) { ChefSpec::SoloRunner.new }
	let(:chef_run)      { chef_instance.converge(described_recipe) }
````

Of course you can merge these statements into one or forego the chef_run.

Just a note with regards to the let statement, the let statement is memoized, this means the block associated with the let statement is run once, the result of the method is returned on subsequent calls.

To test a Windows cookbook on a Linux CI (or vice versa) you can use a product called faixhai to spoof the environment, the statement below will ensure we run as if a Windows 2012 machine

````
	let(:chef_instance) { ChefSpec::SoloRunner.new(platform: 'windows', version: '2012') }
````

The platforms supported by fauxhai are here https://github.com/customink/fauxhai/tree/master/lib/fauxhai/platforms

Here is a brief explaination of the stop_services_spec file

Some versions of the ChefDK / ChefSpec only include libraries for the platform they are running on, out Linux CI system will not have the Win32 code loaded so we've stubbed the code.

````
unless Module.const_defined?("Win32::Service")
    module Win32
        module Service
        end
    end
end
````

When running on a Windows platform Ruby declares different values for some constants, we are running on a Linux CI so will have to stub those to pretend we are running on Windows

``` 
        stub_const('File::PATH_SEPARATOR', ';')
        stub_const('File::ALT_SEPARATOR', "\\")
````

The Shell environment variabkes that Ruby is running in will be different for Windows and Linux so we have to stub anything that would be available in one and not the other
```` 
		stub_const('ENV', {'PROGRAMFILES(x86)' => 'C:\Program Files (x86)'})
````
	
Some basic RSpec stubbing

````
		allow(Win32::Service).to receive(:exists?).with('nxlog').and_return(true)
````

Setting node values, one of the advantages of separating the instance of Chef running and converge statement
````
		chef_instance.node.set['hostname'] = 'Test Node'
````

Run these tests by changing to the root folder (where this README.md file is contained) and typing RSpec, if necessary include pry and add breakpoints to step through the code.

License and Authors
-------------------
Authors: Chris Sullivan
