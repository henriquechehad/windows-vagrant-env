# -*- mode: ruby -*-
# vi: set ft=ruby :

# PATHS
FILE_CACHE_PATH = "c:/chef/cache"
FILE_BACKUP_PATH = "c:/chef/backup"

CURRENT_PATH = File.dirname(__FILE__)

Vagrant.configure("2") do |config|
    config.vm.define "vagrant-windows"
    config.vm.box = "opentable/win-2008r2-standard-amd64-nocm"

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

    config.vm.provision "chef_solo" do |chef|
        chef.log_level = :debug
        chef.file_cache_path = FILE_CACHE_PATH
        chef.file_backup_path = FILE_BACKUP_PATH
        chef.cookbooks_path = "cookbooks"
        chef.json.merge!(JSON.parse(File.read(CURRENT_PATH+"/chef.json")))
    end

    config.vm.provider "virtualbox" do |v|
        v.gui = true
    end

end
