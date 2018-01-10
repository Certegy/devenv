#!/bin/bash

/etc/init.d/networking stop
cp /vagrant/etc/network/interfaces /etc/network/interfaces
sed -i 's/:ip/'"$1"'/g' /etc/network/interfaces
sed -i 's/:netmask/'"$2"'/g' /etc/network/interfaces
/etc/init.d/networking start
