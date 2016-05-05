# Include all of the methods available in MyCompany::Software
Chef::Recipe.send(:include, ::MyCompany::Software)
Chef::Resource::Package.send(:include, ::MyCompany::Software)

# Use the resource at Converge Time
package 'super_software' do
	source '/installers'
	action :install
    only_if { install? }
end

# Use the resource at Compile Time
if apply_config?
    file '/software/configure.txt' do
        content '<settings>run_software = true</settings>'
        action :create
    end
end