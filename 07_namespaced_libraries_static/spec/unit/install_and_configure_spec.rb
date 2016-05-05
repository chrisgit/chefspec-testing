require 'spec_helper'
require 'unit/install_and_configure_support'

describe 'namespaced_mixin::install_and_configure' do
	let(:chef_instance) { ChefSpec::SoloRunner.new(platform: 'windows', version: '2012') }

	before do
        stub_windows_constants
	end

    context 'when software not installed' do
        it 'should install and configure software' do
            allow(MyCompany::Software).to receive(:apply_config?).and_return(true) #=> Used in Compile Phase
            
            chef_run = chef_instance.converge(described_recipe) do
                allow(MyCompany::Software).to receive(:install?).and_return(true) #=> Used in Converge Phase
            end
            
            expect(chef_run).to install_package('super_software')
            expect(chef_run).to create_file('/software/configure.txt')
       end
    end
    
    context 'when software already installed' do
        it 'should install and configure software' do
            allow(MyCompany::Software).to receive(:apply_config?).and_return(false) #=> Used in Compile Phase 
            
            chef_run = chef_instance.converge(described_recipe) do
                allow(MyCompany::Software).to receive(:install?).and_return(false) #=> Used in Converge Phase
            end
            
            expect(chef_run).to_not install_package('super_software')
            expect(chef_run).to_not create_file('/software/configure.txt')
       end
    end

end