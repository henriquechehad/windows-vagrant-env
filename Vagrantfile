# -*- mode: ruby -*-
# vi: set ft=ruby :

# Configure the MS SQL password
MSSQL_PASSWORD = "0SetAPassword!"

# PATHS
FILE_CACHE_PATH = "c:/chef/cache"
FILE_BACKUP_PATH = "c:/chef/backup"

Vagrant.configure("2") do |config|
    config.vm.define "vagrant-windows"
    config.vm.box = "opentable/win-2008r2-standard-amd64-nocm"

    # You should be using the vagrant-windows Vagrant Plugin!
    # Admin user name and password
    config.winrm.username = "Administrator"
    config.winrm.password = "vagrant"

    config.vm.guest = :windows
    config.windows.halt_timeout = 15

    # Terminal Server
    config.vm.network :forwarded_port, guest: 3389, host: 3389

    # WinRM
    config.vm.network :forwarded_port, guest: 5985, host: 5985

    # SQL Server
    config.vm.network :forwarded_port, guest: 1433, host: 1433

    # Check Chef version
    config.omnibus.chef_version = :latest

    # Berkshelf
    config.berkshelf.enabled = true
    config.berkshelf.berksfile_path = "./Berksfile"


    # Install SQL Server and .NET Framework
    config.vm.provision :chef_solo do |chef|
        chef.log_level = :debug
        chef.file_cache_path = FILE_CACHE_PATH
        chef.file_backup_path = FILE_BACKUP_PATH
        chef.add_recipe "windows::default"
        chef.add_recipe "windows::reboot_handler"
        chef.add_recipe "dotnetframework::default"
        chef.add_recipe "sql_server::default"
        chef.add_recipe "sql_server::server"

        chef.json={
            "windows"=>{
                "reboot_timeout" => 15
            },
            "sql_server" => {
                "accept_eula" => true,
                "server_sa_password" => MSSQL_PASSWORD,
            },
            "dotnetframework"=>{
                "version" => "4.5.2",
            },
        }
    end

    config.vm.provision :shell, path: "scripts/create-database.cmd"
    config.vm.provision :shell, path: "scripts/disable-firewall.cmd"

    config.vm.provider "virtualbox" do |v|
        v.gui = true
    end

end
