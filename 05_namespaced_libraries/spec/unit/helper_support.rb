# Constants used in the test, these are fake responses from calling shellout
WINDOWS_VERSION = 'Microsoft Windows [Version 6.1.7601]'    
ENVIRONMENT_SETTINGS = <<-EOF
    PROGRAMDATA=C:\ProgramData
    PROGRAMFILES=C:\Program Files (x86)
    PROGRAMFILES(X86)=C:\Program Files (x86)
    PROGRAMW6432=C:\Program Files
EOF

# Dummy module so that we can add our library as a mixin just as we would with Chef::Recipe or Chef::Resource
# Our library code references the node object which is available on Chef::Recipe and Chef::Resource so similate that too
module MyCompany
	class Test
		def initialize(node)
			@node = node
		end
			
		def node
			@node
		end
	end
end

# Create a node object, set the values
def create_node(settings)
    node_object = Chef::Node.new
    settings.each_pair do |k,v|
        # Create the node object to inject into our dummy class
        node_object.set[k] = v
        node_object.set[k] = v
    end
end

# Stub the shellout command
def create_shellout_stub
    shellout = double(run_command: nil, error!: nil, stderr: double(empty?: true))
    allow(shellout).to receive(:live_stream=).and_return(nil)
    allow(shellout).to receive(:live_stream).and_return(nil)
    allow(Mixlib::ShellOut).to receive(:new).and_return(shellout)
    shellout
end