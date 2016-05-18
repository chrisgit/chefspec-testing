# Use the resource at Converge Time
package 'super_software' do
	source '/installers'
	action :install
    only_if { MyCompany::Software.install? }
end

# Use the resource at Compile Time
if MyCompany::Software.apply_config?
    file '/software/configure.txt' do
        content '<settings>run_software = true</settings>'
        action :create
    end
end