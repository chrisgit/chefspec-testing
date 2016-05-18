Stubbing 01
====================
The example code here contains a stub for File.exists? but goes on to call the original code (i.e. it will actually running File.exists?)

````
allow(File).to receive(:exists?).with(anything).and_call_original
````

When I see code like this there are a few alarms bells that go off,
* Use of anything as a parameter (implying we don't know what the values would be)
* Use of .and_call_original, puzzling as we had taken the trouble to stub the File.exist? method

This was code that I've seen in a test and wondered why so ran the code without the .and_call_original which caused the tests to fail with an error

````
================================================================================
Recipe Compile Error in C:\Users\...\cookbooks\stubbing\attributes\default.rb
================================================================================

IOError
-------
Cannot open or read C:\Users\...\cookbooks\stubbing\attributes\default.rb!

F

Failures:

  1) stubbing::configure_software when new configuration file is available should remove the old configuration and add new configuration
     Failure/Error: let(:chef_run) { chef_instance.converge(described_recipe) }

     IOError:
       Cannot open or read C:\Users\...\cookbooks\stubbing\attributes\default.rb!
     # ./spec/unit/configure_software_spec.rb:8:in `block (2 levels) in <top (required)>'
     # ./spec/unit/configure_software_spec.rb:18:in `block (3 levels) in <top (required)>'

Finished in 2.56 seconds (files took 15.47 seconds to load)
1 example, 1 failure

Failed examples:

rspec ./spec/unit/configure_software_spec.rb:16 # stubbing::configure_software when new configuration file is available should remove the old configuration and add new configuration

````

It looks like Fauxhai is using the File.Exists? method, so our problem statement becomes
* We want to stub File.exist? and use fauxhai to spoof our platform.

Run these tests by changing to the root folder (where this README.md file is contained) and typing RSpec, if necessary include pry and add breakpoints to step through the code.

NB: Running this example will fail, that is intentional.

The rest of the examples for stubbing will change the way the stubs are performed to fix the tests!

License and Authors
-------------------
Authors: Chris Sullivan
