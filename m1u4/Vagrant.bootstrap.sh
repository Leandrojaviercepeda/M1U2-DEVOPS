#!/bin/bash

# Update packages
sudo apt-get update -y

# hosts
if [ -f "/tmp/hosts" ]; then
	sudo mv -f /tmp/hosts /etc/hosts
fi

##Swap
if [ ! -f "/swapdir/swapfile" ]; then
	sudo mkdir /swapdir
	cd /swapdir
	sudo dd if=/dev/zero of=/swapdir/swapfile bs=1024 count=2000000
  	sudo chmod 600 /swapdir/swapfile
	sudo mkswap -f  /swapdir/swapfile
	sudo swapon swapfile
	echo "/swapdir/swapfile       none    swap    sw      0       0" | sudo tee -a /etc/fstab /etc/fstab
	sudo sysctl vm.swappiness=10
	echo vm.swappiness = 10 | sudo tee -a /etc/sysctl.conf
fi

# Install Puppet package
if [ ! -x "$(command --version puppet master)" ]; then
	wget https://apt.puppetlabs.com/puppet8-release-bionic.deb
	sudo dpkg -i puppet8-release-bionic.deb
fi

# Install Puppet Master
if [ ! -x "$(command --version puppet master)" ]; then
	sudo apt-get update -y
	sudo apt-get install puppetserver -y
fi

# Install Puppet Agent
if [ ! -x "$(command --version puppet agent)" ]; then
	sudo apt-get update -y
	sudo apt-get install puppet-agent -y
fi

sudo systemctl start puppet
sudo systemctl enable puppet

# Install jenkings with puppet
puppet module install puppet-jenkins --version 3.3.0