class Configuration
	def apply_config?
		not ::File.exist?('/software/configure.txt')
	end
	
	def install?
		not ::File.exist?('/programs/widget_software')
	end
end

class SoftwareConfiguration < Configuration
end

module MyCompany
	module Software
		def self.apply_config?
			SoftwareConfiguration.new().apply_config?		
		end

		def self.install?
			SoftwareConfiguration.new().install?
		end
	end
end 
