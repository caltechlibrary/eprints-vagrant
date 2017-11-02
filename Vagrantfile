Vagrant.configure("2") do |config|
  #
  # Ubuntu instance to host EPrints 3.3.x for development
  #
  config.vm.network "private_network", type: "dhcp"

  # EPrints v3.3.15 Install manual and debian package expected Ubuntu 14.04 or Debian 7.0
  config.vm.box = "ubuntu/trusty64"
  config.vm.provider "virtualbox" do |vb|
   # Display the VirtualBox GUI when booting the machine
   vb.gui = false
   # Customize the amount of memory on the VM:
   vb.memory = "2048"
   vb.cpus = 4
   # Example custom settings: v.customize ["modifyvm", :id, "--vram", "<vramsize in MB>"]
   vb.customize ["modifyvm", :id, "--vram", "128"]
  end

  config.vm.provision "shell", inline: <<-SHELL
    echo "deb http://deb.eprints.org/ stable/" > /etc/apt/sources.list.d/eprints.list
    apt-get update
SHELL

end
