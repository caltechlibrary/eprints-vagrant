Vagrant.configure("2") do |config|
  #
  # Ubuntu instance to host EPrints 3.4.x for development
  #
  config.vm.network "private_network", type: "dhcp"
  #config.vm.network "forwarded_port", guest: 80, host: 8080
  #config.vm.network "forwarded_port", guest: 443, host: 8443

  config.vm.box = "ubuntu/bionic64"
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false
    # Customize the amount of memory on the VM:
    vb.memory = "2048"
    vb.cpus = 4
    # Example custom settings: v.customize ["modifyvm", :id, "--vram", "<vramsize in MB>"]
    vb.customize ["modifyvm", :id, "--vram", "128"]
  end
end
