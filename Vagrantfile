# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "centos7.0"
  config.vm.network "private_network", ip: "192.168.33.29"
  config.ssh.insert_key = false

  config.vm.provider :virtualbox do |vb|
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate//vagrant","1"]
  end

  config.vm.provision :shell, :path => "./provision/docker-install.sh",:privileged => true,:run => "always"
end
