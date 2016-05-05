# Method sets up stubs with canned responses to keep the boundary to the Chef::Recipe and Chef::Resource
def stub_mycompany_software_library(value)
    # We do not target a specific instance of the Chef::Recipe or Chef::Resource we say "for any instance of these classes"
    # This is because we apply our namespaced code to the underlying Chef::Recipe or Chef::Resource class definition
    allow_any_instance_of(Chef::Resource::Package).to receive(:install?).and_return(value)
    allow_any_instance_of(Chef::Recipe).to receive(:apply_config?).and_return(value)
end

def stub_windows_constants
    stub_const('File::PATH_SEPARATOR', ';')
    stub_const('File::ALT_SEPARATOR', "\\")
    stub_const('ENV', {'PROGRAMFILES(x86)' => 'C:\Program Files (x86)'})
end
