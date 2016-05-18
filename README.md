ChefSpec - Testing
====================
When developing Chef cookbooks you will (hopefully) manually test your work to ensure your converge is successful.

Manual testing can be time consuming and prone to error, most developers (and testers) want to impliment automated tests. 

If you imbue the Chef eco system it won't be long before you are introduced to an integration test tool like ServerSpec or Inspec.

Integration tests are good but because they exercise entire systems or sub-systems the feedback can be slow and debugging any issues time consuming.

When code reviewing test suites for ServerSpec or Inspec I'd noticed a common pattern occuring; although there would be several test suites written by the developers the only variances were for slight changes in behavior.
Typically those variances would be to include a recipe, guard a resource or sometimes just vary the content of a configuration file.

Wouldn't it be great if there was a unit testing framework for Chef to test behaviors and give faster feedback?

The incredible news is that there is a unit testing framework for Chef, not only that, it's really rather good. 

ChefSpec is a unit testing framework written by Seth Vargo; you can find ChefSpec here: https://github.com/sethvargo/chefspec

What I really like about ChefSpec is the comprehensive documentation complete with an excellent examples folder.
The examples really are your stub code and greatly speed up the process to using ChefSpec, a lot of developers I know have tested their code and behaviors by adapting the examples.

Unfortunately there will come a time when the ChefSpec tests do not work or there is a complex recipe under test.

The purpose of these examples is to address questions that I have been asked, typically these are around the use of RSpec and/or Ruby as opposed to ChefSpec.

For example
* RSpec: What is the let statement, why do we use the let statement, where can I place the let statement
* How can I stub a constant
* What is the difference between "describe", "context" and "it" blocks
* Explain usage of Before(:each) v Before(:all) and After(:each) v After (:all) and Around(:each), when are those blocks run?
* How do I write shared tests

Once the basic understand of RSpec has been learnt the remainder of the questions relate to testing code in Chef libraries which is the main reason for these examples.

My recommendation is to view the examples in order (01..07).

Chef is a great DSL but knowledge of Ruby and the underlying framework are invaluable.

Learning resource
-----------------
Ruby
* The Ruby Programming Language by David Flanagan and Yukihiro Matsumoto http://shop.oreilly.com/product/9780596516178.do
* The 'pickaxe' book by Dave Thomas https://pragprog.com/book/ruby/programming-ruby

RSpec
* The RSpec Book (pragmatic programmers) by David Chelimsky https://pragprog.com/book/achbd/the-rspec-book
* RelishApp https://www.relishapp.com/rspec

Testing
* xUnit Test Patterns by Gerard Meszaros http://xunitpatterns.com/
* Practical object-orientated design in Ruby by Sandi Metz http://www.poodr.com/
* The Art Of Unit Testing by Roy Osherove http://artofunittesting.com/


License and Authors
-------------------
Authors: Chris Sullivan
