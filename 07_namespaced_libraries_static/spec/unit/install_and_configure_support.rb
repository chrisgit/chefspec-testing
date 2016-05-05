# Declare our module
# Library changed to only declare the module if not previously declared, alternative is to monkey patch cookbook compiler - load_libraries_from_cookbook method
module MyCompany
    module Software
    end
end

# Stub constants for Windows
def stub_windows_constants
    stub_const('File::PATH_SEPARATOR', ';')
    stub_const('File::ALT_SEPARATOR', "\\")
    stub_const('ENV', {'PROGRAMFILES(x86)' => 'C:\Program Files (x86)'})
end
