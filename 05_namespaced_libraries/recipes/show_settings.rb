# Include all of the methods available in MyCompany::QueryEnvironment namespace in the Chef::Recipe and Chef::Resource::Batch
Chef::Recipe.send(:include, ::MyCompany::QueryEnvironment)
Chef::Resource::Log.send(:include, ::MyCompany::QueryEnvironment)

# This method call is converge phase
log 'Current Environment Settings' do
    message "Current Environment is:\n#{get_environment_settings}"
    action :write
end

# This method call is compile phase
os_version = get_version
if os_version.include?('Microsoft Windows') && os_version.include?('6.1')
    log 'You are running Windows 6.1!'
end
