Stubbing 03
===========
(cont.)
Problem: We want to stub File.exist? and use fauxhai to spoof our platform.

We've used File.exists? in our code but sometimes the better way write Ruby methods that ask questions is to ask in the singular form, it makes more sense and reads better.

The File class has an exists? method and an exist? method, the exists? method is marked for deprecation so it's best to use exist?. 

In doing this we may have avoided some awkward stubbing but it wouldn't have been as much fun to debug!

Run these tests by changing to the root folder (where this README.md file is contained) and typing RSpec, if necessary include pry and add breakpoints to step through the code. 

License and Authors
-------------------
Authors: Chris Sullivan
