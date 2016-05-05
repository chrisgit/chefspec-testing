module MyCompany
	module QueryEnvironment

		include Chef::Mixin::ShellOut

		def get_version
			opts = {}
			opts[:cwd] = 'C:/'
			shell_cmd = node['version_command']
			shell_result = shell_out(shell_cmd, opts)
			shell_result.stdout
		end

		def get_environment_settings
			opts = {}
			opts[:cwd] = 'C:/'
			shell_cmd = node['environment_command']
			shell_result = shell_out(shell_cmd, opts)
			shell_result.stdout
		end

	end
end
