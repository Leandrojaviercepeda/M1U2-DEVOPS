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

# Install curl
if [ ! -x "$(command -v curl)" ]; then
	sudo apt-get install curl -y
fi

# Docker freshinstall
sudo apt-get update -y && apt-get remove docker docker-engine docker.io containerd runc -y

# Docker install
if [ ! -x "$(command -v docker)" ]; then
	# Set up the repository
	sudo apt-get install ca-certificates curl gnupg -y
	sudo install -m 0755 -d /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg	
	sudo chmod a+r /etc/apt/keyrings/docker.gpg
	echo \
		"deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
		"$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
		sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

	# Install Docker Engine
	sudo apt-get update -y
	sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
fi

# Install docker compose plugin
if [ ! -x "$(command version docker compose)" ]; then
	sudo apt-get update -y
	sudo apt-get install docker-compose-plugin -y
fi

# Build docker compose application
cd /tmp/ci-cd/comics
sudo docker compose up -d