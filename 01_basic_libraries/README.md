Basic Chef Libraries
====================
When writing Chef recipies you will eventually need to write some Ruby code.

My preference is to ensure that Chef Recipe files only have resources declared in them and are free of Ruby code, this means all Ruby code will be pushed to libraries.

Library code should be unit tested in the same way as any other piece of code.

If your Library code is declared inside methods that are not namespaced they will automatically be available to Chef resources and Chef recipies but you do not need a recipe in order to test the library function.

To test a library function or Ruby code all you need is a basic understanding of RSpec.

In this example we have two basic library functions we might use in a Chef recipe, one merges the hostname and ipaddress, the other gets the version number from a version.txt file.

````
def merge_computername_ipv4
  "#{node['hostname']}-#{node['ipaddress'].gsub('.','')}"
end

def get_installed_version
  version_file = node['Version_File']
  File.exist?(version_file) ? IO.read(version_file).strip : ''
end
````

Both bits of use a Chef specific object; node. 

When testing with node you can simply replace it with a Hash (helpers_spec.rb) or use Chef::Node class (helpers_alt_spec).

The spec_helper contains 

````
Dir['libraries/*.rb'].each { |f| require File.expand_path(f) }
````

This will load all of the *.rb files in the library folder, as there is only one file (helpers.rb) we could have used require_relative or require to load that one file.

Run these tests by changing to the root folder of this example (where this README.md file is contained) and typing RSpec, if necessary include pry and add breakpoints to step through the code.

License and Authors
-------------------
Authors: Chris Sullivan
