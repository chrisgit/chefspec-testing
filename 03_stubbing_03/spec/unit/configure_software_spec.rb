# Rename this to configure_software_spec to see the error
require 'spec_helper'

describe 'stubbing::configure_software' do
  let(:chef_instance) { ChefSpec::SoloRunner.new(platform: 'windows', version: '2012') }
  let(:chef_run) { chef_instance.converge(described_recipe) }

  before(:each) do
    allow(File).to receive(:exist?).with(anything).and_return(true) # <= Change to File.exist? reads better and File.exists? will be deprecated
    # still not correct as this may produce incorrect results
    stub_const('File::PATH_SEPARATOR', ';')
    stub_const('File::ALT_SEPARATOR', "\\")
		stub_const('ENV', {'PROGRAMFILES(x86)' => 'C:\Program Files (x86)'})
  end

  describe 'when new configuration file is available' do
    it 'should remove the old configuration and add new configuration' do
      expect(chef_run).to run_execute('remove old configuration')
      expect(chef_run).to run_execute('add new configuration')
    end
  end
end
