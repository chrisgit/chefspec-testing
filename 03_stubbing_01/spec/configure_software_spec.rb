# Rename this to configure_software_spec to see the error
require 'spec_helper'

describe 'stubbing::configure_software' do
  ENV['PROGRAMFILES(x86)'] = 'C:\Program Files (x86)' #=> Or use stub_const

  let(:chef_instance) { ChefSpec::SoloRunner.new(platform: 'windows', version: '2012') } #=> Pretend to be Windows 2012
  let(:chef_run) { chef_instance.converge(described_recipe) }

  before(:each) do
    allow(File).to receive(:exists?).with(anything) # <= We want to stub File.exists? but stubbing here will stop Chef / Fauxhai
    #allow(File).to receive(:exists?).with(anything).and_call_original # <= May work but I do not recommend this
  end

  describe 'when new configuration file is available' do
    it 'should remove the old configuration and add new configuration' do
      # Need to re-stub File.exists? here to prove tests ...
      allow(File).to receive(:exists?).and_return(true)

      expect(chef_run).to run_execute('remove old configuration')
      expect(chef_run).to run_execute('add new configuration')
    end
  end
end
