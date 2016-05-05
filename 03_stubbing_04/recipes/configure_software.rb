# Shows a File exists? stubbing issue (code below changed to use File exist?)

new_configuration_file = File.join(node['install_folder'], 'cfg', 'new_configuration.txt')

execute 'remove old configuration' do
  cwd File.join(node['install_folder'], 'bin')
  command 'software_package.exe --remove'
  only_if { ::File.exist?(new_configuration_file) }
end

execute 'add new configuration' do
  cwd File.join(node['install_folder'], 'bin')
  command 'software_package.exe --add '
  only_if { ::File.exist?(new_configuration_file) }
end

log "End of configure software for #{node['hostname']}"
