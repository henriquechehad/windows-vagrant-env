
# Create directory c:\aplicativos\sia
directory 'c:\\aplicativos' do
  action :create
end

directory 'c:\\aplicativos\\sia\\' do
  action :create
end

# Create sia.ini file
cookbook_file 'c:\\aplicativos\\sia\\sia.ini' do
    source "sia.ini"
end

# Install SIA setup
windows_package 'sia-setup.exe' do
    source node['sia']['url']
    installer_type :inno
    action :install
end
