module MyCompany
	module Software
		def apply_config?
			not ::File.exist?('/software/configure.txt')
		end

		def install?
			not ::File.exist?('/programs/widget_software')
		end
	end
end
