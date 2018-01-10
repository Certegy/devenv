require_relative 'box'

# see http://sysadm.pp.ua/linux/sistemy-virtualizacii/vagrantfile.html
servers=[
   {
      :name => "galaxy",
      :provision => ["rabbitmq","sqlserver"],
      :ip => "192.168.81.2",
      :port => 15672,
      :netmask => "255.255.255.0",
      :box => $USE_EXISTING_BOX ? $EXISTING_BOX_NAME : "ubuntu/xenial64",
      :memory => 4096,
      :cpus => 2
   }
]

Vagrant.configure(2) do |config|

   servers.each do |server|

      config.vm.define server[:name] do |guest|

         # basic settings
         guest.vm.box = server[:box]
         guest.vm.hostname = server[:name]
         guest.hostmanager.enabled = true
         guest.hostmanager.manage_host = true
         guest.hostmanager.manage_guest = true
         guest.hostmanager.ignore_private_ip = false
         guest.hostmanager.include_offline = true

         # configure NAT/Host-only network. This allows for host->guest, guest->host and guest->guest communication
         guest.vm.network "private_network", ip: server[:ip], :netmask => server[:netmask], auto_config: false
         guest.vm.provision "shell", path: "provision/networking.sh", :args => [server[:ip], server[:netmask]]
         # configure proxy
         guest.vm.provision "shell", path: "provision/proxy.sh", :args => ["#{ENV['HTTP_PROXY']}"]
         # provisioning
         if $PROVISIONING_REQUIRED
            server[:provision].each do |script|
               guest.vm.provision "shell", path: "provision/#{script}.sh"
            end
         end

         guest.vm.provider "virtualbox" do |vb|
            vb.name = server[:name]
            vb.memory = server[:memory]
            vb.cpus = server[:cpus]
         end

         # guest.vm.provider "hyperv" do |hv|
         #    hv.vmname = server[:name]
         #    hv.memory = server[:memory]
         #    hv.cpus = server[:cpus]
         # end

      end

   end

end
