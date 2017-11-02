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
    apt-get update
#    apt-get upgrade -y
#    apt-get install -y perl libncurses5 libselinux1 libsepol1 apache2 libapache2-mod-perl2 libxml-libxml-perl libunicode-string-perl \
#        libterm-readkey-perl libmime-lite-perl libmime-types-perl libdigest-sha-perl libdbd-mysql-perl libxml-parser-perl libxml2-dev \
#        libxml-twig-perl libarchive-any-perl libjson-perl lynx wget ghostscript xpdf antiword elinks pdftk texlive-base texlive-base-bin \
#        psutils imagemagick adduser tar gzip mysql-server mysql-client unzip libsearch-xapian-perl \
#        git autoconf autoconf-archive aptitude
SHELL

end
