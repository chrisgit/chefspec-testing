file_to_load = File.expand_path('module_to_load.rb', __dir__)
Kernel.load(file_to_load)

module CompanyA
	class Software
		def installed?
			true
		end
		
		def one_plus_one
			add_numbers(1,1)
		end
	end
end

x = CompanyA::Software.new
puts "Tracking where our methods come from ..."

puts "The method :add_numbers is found in .... #{x.method(:add_numbers)}" 

puts "The owner of :add_numbers is .... #{x.method(:add_numbers).owner}" 

puts "The source location of :add_numbers is .... #{x.method(:add_numbers).source_location}" 

puts "The inheritance trail of the Software Class (instance) is .... #{x.class.ancestors}" 

puts "Object private instance methods #{Object.private_instance_methods}" 

puts "private methods contains :add_numbers #{Object.private_methods.grep(/add/)}" 

puts "Methods just for CompanyA::Software #{CompanyA::Software.instance_methods - Object.instance_methods}" 
