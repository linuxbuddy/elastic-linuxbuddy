VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "boxcutter/centos64-i386"

  config.vm.boot_timeout = 300

  config.vm.post_up_message = "Welcome to the LinuxBuddy development environment."

  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = "512"
  end

  config.vm.network "private_network", ip: "192.168.100.4"
  config.vm.network :forwarded_port, guest: 80, host: 8888
  config.vm.hostname = "linuxbuddy.dev"

  config.vm.provision "development", type: "shell" do |sh|
    sh.path = "provisioning/bootstrap.sh"
  end

end