# CCP development environment provisioning

## Pre-requisites

* PowerShell
* Vagrant
* VirtualBox

## Usage

There are 2 commands that need to get run. The first creates the host-only network (with DHCP disabled) that allows us to statically assign IP addresses to specific servers. The subsequent vagrant script brings up the following dev servers:
* RabbitMQ server on 192.168.81.2
* Docker server hosting existing containerised microservices on 192.168.81.3

The commands are as follows:

    > ./hostonly.ps1
    > vagrant up dev

### RabbitMQ

To access the RabbitMQ management console navigate to http://192.168.81.2:15672 and login with test/test

### Docker

coming soon
