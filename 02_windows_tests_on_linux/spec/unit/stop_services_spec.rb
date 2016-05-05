require 'spec_helper'

# If Chef does not pull in the relevant platform specific libraries you will have to declate them yourself
# Recommend these go into a helper or support file to keep the test code clean and clear
unless Module.const_defined?("Win32::Service")
    module Win32
        module Service
        end
    end
end

describe 'windows_tests_on_linux::stop_services' do
    
    # Specify the platform, see https://github.com/customink/fauxhai/tree/master/lib/fauxhai/platforms
	let(:chef_instance) { ChefSpec::SoloRunner.new(platform: 'windows', version: '2012') }
	let(:chef_run)      { chef_instance.converge(described_recipe) }

    # Change to stub_const
	before do
        stub_const('File::PATH_SEPARATOR', ';')
        stub_const('File::ALT_SEPARATOR', "\\")
		stub_const('ENV', {'PROGRAMFILES(x86)' => 'C:\Program Files (x86)'})
	end
	
	it 'should stop logging service if installed' do
		allow(Win32::Service).to receive(:exists?).with('nxlog').and_return(true)
		chef_instance.node.set['hostname'] = 'Test Node'
        
		expect(chef_run).to stop_service('nxlog')
	end

	it 'should do nothing is logging service is not installed' do
		allow(Win32::Service).to receive(:exists?).with('nxlog').and_return(false)
		chef_instance.node.set['hostname'] = 'Test Node'
		
		expect(chef_run).not_to stop_service('nxlog')
	end
	
end
