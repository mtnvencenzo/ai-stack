# ============================================================================
# Install Docker Engine
# https://docs.docker.com/engine/install/linux-postinstall/
# ============================================================================

## Install Prerequisite Packages.
sudo apt install ca-certificates curl gnupg lsb-release -y

## Add Docker's GPG Key.
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

## Add Docker Repository to APT Sources.
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

## To install the latest version, run:
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

sudo systemctl status docker
sudo systemctl start docker


## Test docker installation
sudo docker run hello-world


## (Optional) To allow non root access to docker command (and gpu access)
sudo groupadd docker
sudo usermod -aG docker $USER
sudo usermod -aG video $USER
newgrp docker

## Or, to remove a user from the group docker:
sudo gpasswd -d $USER docker
sudo gpasswd -d $USER video


## Start or disable on boot
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

sudo systemctl disable docker.service
sudo systemctl disable containerd.service