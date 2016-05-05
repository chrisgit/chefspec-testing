# Rename this to configure_software_spec to see the error
require 'spec_helper'

describe 'stubbing::configure_software' do
  let(:chef_instance) { ChefSpec::SoloRunner.new(platform: 'windows', version: '2012') }
  let(:chef_run) { chef_instance.converge(described_recipe) }

  before(:each) do
    stub_const('File::PATH_SEPARATOR', ';')
    stub_const('File::ALT_SEPARATOR', "\\")
		stub_const('ENV', {'PROGRAMFILES(x86)' => 'C:\Program Files (x86)'})
  end

  describe 'when new configuration file is available' do
    it 'should remove the old configuration and add new configuration' do
      # Just stub further down the chain
      chef_instance.converge(described_recipe) do
        new_configuration_file = File.join(chef_instance.node['install_folder'], 'cfg', 'new_configuration.txt')
        allow(File).to receive(:exist?).and_return(true) # <= All calls to exist? will return true, could replace with .and_call_original but do not specify parameter values
        allow(File).to receive(:exist?).with(new_configuration_file).and_return(true) # Stub specific parameters to method
      end

      expect(chef_run).to run_execute('remove old configuration')
      expect(chef_run).to run_execute('add new configuration')
    end
  end
end
