# Just test the libraries with raw Ruby/RSpec - does not require ChefSpec

# ChefSpec will normally load any Chef modules for us, here is required for Chef::Node but we could use a Hash instead
require 'chef'
require 'spec_helper'
require 'unit/helper_support'

describe MyCompany::QueryEnvironment do
    before(:each) do
        # In support file
        node_object = create_node({ 'version_command' => 'test_get_version', 'environment command' => 'test_get_environment' })

        # Create an instance of our test class and inject the node object
        @dummy_class = MyCompany::Test.new node_object
        # Make our methods available to the Test object, 
        # NB: Normally the definition of Chef::Recipe or Chef::Resource is changed rather than single instance extended
        @dummy_class.extend(MyCompany::QueryEnvironment)

        # Stub out the shell_out method as this will cross our test boundary
        @shellout = create_shellout_stub
    end

	describe 'get_version' do
        it 'should return the operating system version' do
            allow(@shellout).to receive(:stdout).and_return(WINDOWS_VERSION)

            expect(@dummy_class.get_version).to eq WINDOWS_VERSION #=> Weak tests as we are asserting what we've stubbed
        end
   end
   
   describe 'get_environment_settings' do
       it 'should return the environment variables' do
            allow(@shellout).to receive(:stdout).and_return(ENVIRONMENT_SETTINGS)

            expect(@dummy_class.get_environment_settings).to eq ENVIRONMENT_SETTINGS #=> Weak tests as we are asserting what we've stubbed
       end
   end
end
 