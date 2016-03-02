#
# Cookbook Name:: main
# Recipe:: default
#

batch 'create-database' do
  code <<-EOH
    @echo off
    echo Disabling firewall
    netsh advfirewall set allprofiles state off
    EOH
end

batch 'disable-firewall' do
  code <<-EOH
    @echo off
    echo Creating database...
    "C:\\Program Files\\Microsoft SQL Server\\100\\Tools\\Binn\\SQLCMD.EXE" -S .\\sqlexpress -i C:\\vagrant\\db\\create.sql
    echo Database is created
    EOH
end
