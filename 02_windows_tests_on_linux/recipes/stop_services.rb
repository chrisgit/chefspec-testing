# Stop the event logging service

service 'Papertrail' do
	service_name 'nxlog'
	action [:stop]
	only_if { ::Win32::Service.exists?('nxlog') }
end

log "End of service stop for #{node['hostname']}"
