require 'spec_helper'
require 'unit/install_and_configure_support'
require 'pry'

# Load your library or declare your classes otherwise Constant not exists
#require_relative '../../libraries/helper' 

class Configuration; end
class SoftwareConfiguration < Configuration; end

describe 'namespaced_mixin::install_and_configure' do
	let(:chef_instance) { ChefSpec::SoloRunner.new(platform: 'windows', version: '2012') }

	before do
        stub_windows_constants
	end

    context 'when software not installed' do
        it 'should install and configure software' do
            allow_any_instance_of(SoftwareConfiguration).to receive(:apply_config?).and_return(true)
            
            chef_run = chef_instance.converge(described_recipe) do
                allow_any_instance_of(SoftwareConfiguration).to receive(:install?).and_return(true)
            end
            
            expect(chef_run).to install_package('super_software')
            expect(chef_run).to create_file('/software/configure.txt')
       end
    end
    
    context 'when software already installed' do
        it 'should NOT install and configure software' do
            allow_any_instance_of(SoftwareConfiguration).to receive(:apply_config?).and_return(false)
            
            chef_run = chef_instance.converge(described_recipe) do
                allow_any_instance_of(SoftwareConfiguration).to receive(:install?).and_return(false)
            end
            
            expect(chef_run).to_not install_package('super_software')
            expect(chef_run).to_not create_file('/software/configure.txt')
       end
    end

end