# CCP development environment provisioning

## Pre-requisites

* [VirtualBox](https://chocolatey.org/packages/virtualbox)
* [Vagrant](https://chocolatey.org/packages/vagrant)
* [Vagrant Host Manager plugin](https://github.com/devopsgroup-io/vagrant-hostmanager) - updates the hosts file on the guest machine(s)
* [Vagrant Hostsupdater plugin](https://github.com/cogitatio/vagrant-hostsupdater) - updates the hosts file on the host machine

Install as follows (note - assumes Chocolatey):

    cinst virtualbox
    cinst vagrant
    vagrant plugin install vagrant-hostmanager
    vagrant plugin install vagrant-hostsupdater

Note: You may need to restart your machine for one or more of these steps.

## Proxy settings

If you use a proxy server to access the internet, run the following from an elevated command prompt (where ":proxy" is the address of your proxy server):

    [Environment]::SetEnvironmentVariable("HTTP_PROXY", ":proxy", "Machine")

Alternatively you can manually add a System Environment variable:<br/>
![](https://cloud.githubusercontent.com/assets/10783372/25257454/549411c0-2677-11e7-8134-a347f6b109d3.png)


## Usage

There are 3 commands that need to get run as follows:

    ./hostonly.ps1
    vagrant up
    vagrant hostmanager

The first line creates the host-only network (with DHCP disabled) that allows us to statically assign IP addresses to specific servers.
The second line is the vagrant command that brings up the development environment.
The third line updates the host file on the guest VMs as well as the host.

## Servers

| Description | IP | DNS |
| :--- | :--- | :--- |
| RabbitMQ | 192.168.81.2 | rabbit |
| Docker | 192.168.81.3 | docker |
