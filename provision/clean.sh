#!/bin/bash

# https://scotch.io/tutorials/how-to-create-a-vagrant-base-box-from-an-existing-one
sudo apt-get clean
sudo dd if=/dev/zero of=/EMPTY bs=1M
sudo rm -f /EMPTY
cat /dev/null > ~/.bash_history && history -c && exit
