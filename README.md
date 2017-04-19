# CCP development environment provisioning

## Pre-requisites

* [VirtualBox](https://chocolatey.org/packages/virtualbox)
* [Vagrant](https://chocolatey.org/packages/vagrant)
* [Vagrant Host Manager plugin](https://github.com/devopsgroup-io/vagrant-hostmanager)

Install as follows (note - assumes Chocolatey):

    cinst virtualbox
    cinst vagrant
    vagrant plugin install vagrant-hostmanager

Once the above things are installed, restart machine.

## Proxy settings

If you use a proxy server to access the internet, run the following from an elevated command prompt:

    [Environment]::SetEnvironmentVariable("HTTP_PROXY", ":proxy", "Machine")

where ":proxy" is the address of your proxy server.

## Usage

There are 3 commands that need to get run as follows:

    ./hostonly.ps1
    vagrant up dev
    vagrant hostmanager

The first line creates the host-only network (with DHCP disabled) that allows us to statically assign IP addresses to specific servers.
The second line is the vagrant command that brings up the development environment.
The third line updates the host file on the guest VMs as well as the host.

## Servers

| Description | IP | DNS |
| :--- | :--- | :--- |
| RabbitMQ | 192.168.81.2 | rabbit |
| Docker | 192.168.81.3 | docker |
