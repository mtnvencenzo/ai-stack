# --------------------------------------------------------------
# NVIDIA GPU Support
# --------------------------------------------------------------

## Test gpu support
nvidia-smi
nvidia-container-runtime --version
nvidia-container-runtime-hook --version
dpkg -l '*nvidia*'

# Test docker gpu support
sudo docker run --rm --gpus all nvidia/cuda:12.2.0-base-ubuntu22.04 nvidia-smi


# ================================================================
# Uninstall NVIDIA GPU Support and drivers for a  fresh reinstall
# ================================================================
sudo apt purge --autoremove -y nvidia-container-toolkit
sudo apt purge --autoremove -y nvidia-docker2
sudo rm -rf /etc/nvidia-container-runtime
sudo apt remove --purge nvidia*
sudo apt remove --purge "*cuda*"

sudo apt-get purge nvidia*
sudo apt remove nvidia-*
sudo rm /etc/apt/sources.list.d/cuda*
sudo apt-get autoremove && sudo apt-get autoclean
sudo rm -rf /usr/local/cuda*

## (Optional) Remove source list and keyrings
sudo rm -rf /etc/apt/keyrings/nvidia-container-toolkit.asc
sudo rm -rf /etc/apt/sources.list.d/nvidia-container-toolkit.list


# ================================================================
# Reinstall NVIDIA GPU Support and drivers
# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html
# ================================================================
# Use Software & Updates to add the graphics drivers for Nvidia, found in the Additional Drivers tab

## Install the prerequisites for the instructions below:
sudo apt-get update && sudo apt-get install -y --no-install-recommends \
   curl \
   gnupg2

## Configure the production repository:
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

## Optionally, configure the repository to use experimental packages:
sudo sed -i -e '/experimental/ s/^#//g' /etc/apt/sources.list.d/nvidia-container-toolkit.list

## Update the packages list from the repository:
sudo apt-get update

## Install the NVIDIA Container Toolkit packages:
export NVIDIA_CONTAINER_TOOLKIT_VERSION=1.18.0-1
  sudo apt-get install -y \
      nvidia-container-toolkit=${NVIDIA_CONTAINER_TOOLKIT_VERSION} \
      nvidia-container-toolkit-base=${NVIDIA_CONTAINER_TOOLKIT_VERSION} \
      libnvidia-container-tools=${NVIDIA_CONTAINER_TOOLKIT_VERSION} \
      libnvidia-container1=${NVIDIA_CONTAINER_TOOLKIT_VERSION}

# Update the nvida toolkit cgroup flag to false
cd /etc/nvidia-container-runtime
cat config.toml | grep no-cgroups
# Update it to false if it is true
no-cgroups = false
sudo sed -i 's/no-cgroups = true/no-cgroups = false/g' config.toml
