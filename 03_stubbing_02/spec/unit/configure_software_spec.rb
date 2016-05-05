# Rename this to configure_software_spec to see the error
require 'spec_helper'

describe 'stubbing::configure_software' do
  ENV['PROGRAMFILES(x86)'] = 'C:\Program Files (x86)' #=> Can use stub_const

  let(:chef_instance) { ChefSpec::SoloRunner.new(platform: 'windows', version: '2012') }
  
  describe 'when new configuration file is available' do
    it 'should remove the old configuration and add new configuration' do

      # Stub again, here using ChefSpec's ability to add hooks between compile and converge
      chef_run = chef_instance.converge(described_recipe) do
        new_configuration_file = File.join(chef_instance.node['install_folder'], 'cfg', 'new_configuration.txt')
        allow(File).to receive(:exists?).with(new_configuration_file).and_return(true)
      end

      expect(chef_run).to run_execute('remove old configuration')
      expect(chef_run).to run_execute('add new configuration')
    end
  end
end
