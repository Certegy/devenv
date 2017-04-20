# see http://sysadm.pp.ua/linux/sistemy-virtualizacii/vagrantfile.html
servers=[
   {
      :name => "rabbit",
      :ip => "192.168.81.2",
      :netmask => "255.255.255.0",
      :box => "ubuntu/xenial64",
      :memory => 2048,
      :cpus => 1
   }#,
   # {
   #    :name => "docker",
   #    :ip => "192.168.81.3",
   #    :netmask => "255.255.255.0",
   #    :box => "ubuntu/xenial64",
   #    :memory => 3072,
   #    :cpus => 1
   # }#,
   # {
   #    :name => "db",
   #    :ip => "192.168.81.4",
   #    :netmask => "255.255.255.0",
   #    :box => "windows",
   #    :memory => 4096,
   #    :cpus => 2
   # }
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
         guest.vm.provision "shell", inline: <<-SHELL
            /etc/init.d/networking stop
            cp /vagrant/etc/network/interfaces /etc/network/interfaces
            sed -i 's/:ip/#{server[:ip]}/g' /etc/network/interfaces
            sed -i 's/:netmask/#{server[:netmask]}/g' /etc/network/interfaces
            /etc/init.d/networking start
         SHELL

         # configure proxy settings
         guest.vm.provision "shell", inline: <<-SHELL
            if [ -n "#{ENV['HTTP_PROXY']}" ]; then
               export http_proxy=#{ENV['HTTP_PROXY']}
               export https_proxy=#{ENV['HTTP_PROXY']}
               export no_proxy='no_proxy=localhost,127.0.0.1'
               echo 'http_proxy="'#{ENV['HTTP_PROXY']}'"' >> /etc/environment
               echo 'https_proxy="'#{ENV['HTTP_PROXY']}'"' >> /etc/environment
               echo 'ftp_proxy="'#{ENV['HTTP_PROXY']}'"' >> /etc/environment
               echo 'no_proxy="localhost,127.0.0.1"' >> /etc/environment
               . /etc/environment
               touch /etc/apt/apt.conf
               echo 'acquire::http::proxy "'#{ENV['HTTP_PROXY']}'";' >> /etc/apt/apt.conf
               echo 'acquire::https::proxy "'#{ENV['HTTP_PROXY']}'";' >> /etc/apt/apt.conf
               echo 'acquire::ftp::proxy "'#{ENV['HTTP_PROXY']}'";' >> /etc/apt/apt.conf
            fi
         SHELL

         guest.vm.provision "shell", path: "provision/#{server[:name]}.sh"

         guest.vm.provider "virtualbox" do |vb|
            #vb.gui = true
            vb.name = server[:name]
            vb.memory = server[:memory]
            vb.cpus = server[:cpus]
         end

      end

   end

end
