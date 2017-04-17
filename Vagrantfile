Vagrant.configure(2) do |config|

   # dev environment
   config.vm.define "dev" do |dev|

      # basic settings
      dev.vm.box = "ubuntu/xenial64"
      dev.vm.hostname = "rabbit"

      # configure NAT/Host-only network. This allows for host->guest, guest->host and guest->guest communication
      dev.vm.network "private_network", ip: "192.168.81.2", :netmask => "255.255.255.0", auto_config: false
      config.vm.provision "shell", inline: <<-SHELL
         /etc/init.d/networking stop
         cp /vagrant/interfaces /etc/network/interfaces
         /etc/init.d/networking start
      SHELL

      # install erlang and rabbit
      config.vm.provision "shell", path: "provision.sh"

      # cannot login to rabbit as guest/guest except via localhost
      # therefore create some test credentials with admin permissions
      config.vm.provision "shell", inline: <<-SHELL
         rabbitmqctl add_user test test
         rabbitmqctl set_user_tags test administrator
         rabbitmqctl set_permissions -p / test ".*" ".*" ".*"
      SHELL

      # use VirtualBox provider for dev env
      dev.vm.provider "virtualbox" do |vb|
         vb.gui = true
         vb.name = "rabbit"
         vb.memory = 4096
         vb.cpus = 2
      end
   end

   # production environment
   # config.vm.define "prod" do |prod|
   # end

end
