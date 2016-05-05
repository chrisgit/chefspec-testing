# Tests using Chef::Node
require 'spec_helper'
require 'chef'
require 'unit\test_constants'

describe 'library helper methods' do 
    
	let (:node) do
		node = Chef::Node.new
		node.automatic['hostname'] = WEBSERVER_NAME
		node.automatic['ipaddress'] = WEBSERVER_IPADDRESS
		node.set['Version_File'] = VERSION_FILE
        node
	end

    describe 'merge_computername_ipv4' do 		
        it 'should return computername and ipv4 address' do
			expect(merge_computername_ipv4).to eq "#{WEBSERVER_NAME}-#{WEBSERVER_FORMATTED_IPADDRESS}"
        end
    end

    describe 'get_installed_version' do
        describe 'when the version file exists' do
            it 'should return software version' do
                # We have to stub calls to File.exist? and IO.read as we do not want these to happen
                allow(File).to receive(:exist?).with(VERSION_FILE).and_return(true)
                allow(IO).to receive(:read).with(VERSION_FILE).and_return(SOFTWARE_VERSION)

                expect(get_installed_version).to eq SOFTWARE_VERSION
            end
        end
        describe 'when the version file does not exist' do
            it 'should return empty string' do
                allow(File).to receive(:exist?).and_return(false)

                expect(get_installed_version).to eq ''
            end
        end
    end
end