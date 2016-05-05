module MyCompany
	module Software
		def self.apply_config?
			not ::File.exist?('/software/configure.txt')
		end

		def self.install?
			not ::File.exist?('/programs/widget_software')
		end
	end
end unless defined?(MyCompany::Software) #=> When unit testing the cookbook we have defined the constants and stubbed, hence do no overwrite
