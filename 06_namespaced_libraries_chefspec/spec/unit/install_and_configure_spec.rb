require 'spec_helper'
require 'unit/install_and_configure_support'

describe 'namespaced_mixin::install_and_configure' do
	let(:chef_instance) { ChefSpec::SoloRunner.new(platform: 'windows', version: '2012') }
	let(:chef_run)      { chef_instance.converge(described_recipe) }

	before do
        stub_windows_constants
	end

    context 'when software not installed' do
        it 'should install and configure software' do
            stub_mycompany_software_library(true)
            
            expect(chef_run).to install_package('super_software')
            expect(chef_run).to create_file('/software/configure.txt')
       end
    end
    
    context 'when software already installed' do
        it 'should install and configure software' do
            stub_mycompany_software_library(false)
            
            expect(chef_run).to_not install_package('super_software')
            expect(chef_run).to_not create_file('/software/configure.txt')
       end
    end

end