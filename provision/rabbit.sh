#!/bin/bash

# see http://idroot.net/linux/install-rabbitmq-ubuntu-16-04/
apt-get -y update
apt-get -y upgrade
wget http://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc
apt-key add erlang_solutions.asc
apt-get -y update
apt-get -y install erlang
apt-get -y install erlang-nox
echo "deb http://www.rabbitmq.com/debian/ testing main" >> /etc/apt/sources.list
wget https://www.rabbitmq.com/rabbitmq-signing-key-public.asc
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6B73A36E6026DFCA
apt-key add rabbitmq-signing-key-public.asc
apt-get -y update
apt-get -y install rabbitmq-server
systemctl enable rabbitmq-server
systemctl start rabbitmq-server
rabbitmq-plugins enable rabbitmq_management

# see https://stackoverflow.com/questions/22850546/cant-access-rabbitmq-web-management-interface-after-fresh-install/22854222#22854222
rabbitmqctl add_user test test
rabbitmqctl set_user_tags test administrator
rabbitmqctl set_permissions -p / test ".*" ".*" ".*"
