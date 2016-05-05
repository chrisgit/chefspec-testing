Stubbing 04
===========
(cont.)
Problem: We want to stub File.exist? and use fauxhai to spoof our platform.

When using RSpec to stub out code we sometimes want to specify the parameters and other times not.

If we start to specify the parameter values such as 
````
allow(File).to receive(:exist?).with(new_configuration_file).and_return(true)
````

Then we cannot also specify to accept any parameter like this
````
allow(File).to receive(:exist?).with(anything).and_return(true)
````

What we have to do is create a stub that does not specify a parameter value at all
````
allow(File).to receive(:exist?).and_return(true) 
````

Then the two stub can co-exist
````
allow(File).to receive(:exist?).and_return(true) 
allow(File).to receive(:exist?).with(new_configuration_file).and_return(true)
````

Run these tests by changing to the root folder (where this README.md file is contained) and typing RSpec, if necessary include pry and add breakpoints to step through the code. 

License and Authors
-------------------
Authors: Chris Sullivan
