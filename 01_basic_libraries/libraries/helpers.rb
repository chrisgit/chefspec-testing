def merge_computername_ipv4
  "#{node['hostname']}-#{node['ipaddress'].gsub('.','')}"
end

def get_installed_version
  version_file = node['Version_File']
  File.exist?(version_file) ? IO.read(version_file).strip : ''
end
