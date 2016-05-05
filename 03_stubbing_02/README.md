Stubbing 02
===========
(cont.)
Problem: We want to stub File.exist? and use fauxhai to spoof our platform.

So the first thing we wanted to resolve was the call of 

````
allow(File).to receive(:exists?).with(anything).and_call_original
````

To do that we could make a subtle change so that we could simplify the stubbing of File.exists? and not specify a parameter
````
allow(File).to receive(:exists?).and_call_original
````

This will allow us to stub File.exists? method later with an explicit parameter value such as

````
allow(File).to receive(:exists?).with(new_configuration_file).and_return(true)
````

But the test will still be confusing as it's not obvious why we have the initial stub, it bears no relationship to setting up the test for the SUT/CUT, xUnit Test Patterns says automated tests should
* help improve quality
* help us to understand system under test (SUT)
* reduce risk
* be easy to run
* easy to write and maintain
* require minimal maintenance as the system evolves

Fixing our example
------------------
In the recipe File.exists? is called as part of an only_if guard which runs in Chefs converge phase.

Fortunately ChefSpec offers us a really nice hook for us to supply a code block to be executed between compiling cookbooks and converging.

This means that we can delay the stubbing of File.exists? ensuring that fauxhai has loaded.

The hook in ChefSpec is contained in the Runner class looks like this 

````
def converge(*recipe_names)
      node.run_list.reset!
      recipe_names.each { |recipe_name| node.run_list.add(recipe_name) }
      ....

      # ===================================================================================
      # Allow stubbing/mocking after the cookbook has been compiled but before the converge
      # ===================================================================================
      yield if block_given?

      ....
      @converging = true
      converge_val = @client.converge(@run_context)
      if converge_val.is_a?(Exception)
        raise converge_val
      end
      self
    end
````

Now we can really simplify our code and provide some clarity as to what we are doing; I've removed the chef_run test variable (memoized method) and just use chef_instance combined with the hook.

Run these tests by changing to the root folder (where this README.md file is contained) and typing RSpec, if necessary include pry and add breakpoints to step through the code. 

License and Authors
-------------------
Authors: Chris Sullivan
