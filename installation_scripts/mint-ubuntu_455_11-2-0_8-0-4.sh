#!/bin/bash
# Nvidia driver 455 (?460), cuda 11.2.0 & cudnn 8.0.4 installation for
# Ubuntu 20.04 LTS, Linux Mint
# -
# [28.01.2021]: Taken from:
# https://askubuntu.com/questions/1077061/how-do-i-install-nvidia-and-cuda-drivers-into-ubuntu
# Created 30.10.2020
# Last updated: 07.01.2021

# Note: The NVIDIA driver that comes with CUDA 11.2.0 is the 460 driver which
# does not come with the 32bit drivers which can make apps like Steam fail due
# to missing 32bit libraries. This installation bypasses the installation of
# the proprietary NVIDIA 460 drivers and uses the graphics-drivers PPA instead.
# This also allows for the driver to stay installed after a kernel update.

# PREPARATION - REMOVE AND UPDATE

# Removing any CUDA PPAs that may be setup and also remove the
# nvidia-cuda-toolkit if installed:
sudo rm /etc/apt/sources.list.d/cuda*
sudo apt remove --autoremove nvidia-cuda-toolkit

# Removing all NVIDIA drivers before installing new drivers.
sudo apt remove --autoremove nvidia-*

# Updating the system.
sudo apt update

# INSTALLATION - ADD AND INSTALL
# CUDA installation works with the graphics-drivers ppa so it must be added.
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update

# Installing NVIDIA.
sudo apt install nvidia-driver-455

# Downloading the CUDA 11.2.0 .run file from NVIDIA.
wget https://developer.download.nvidia.com/compute/cuda/11.2.0/local_installers/cuda_11.2.0_460.27.04_linux.run

# Making file executable
chmod +x cuda_11.2.0_460.27.04_linux.run

# CUDA installation
sudo ./cuda_11.2.0_460.27.04_linux.run

# There comes acception the EULA. Unselect the driver by pressing the spacebar
# while [X] Driver is highlighted. Then press the down arrow to Install.
# Press Enter then wait for installation to complete.

# [NOT NECESSARY]: After the installation is complete add the following to the
# bottom of your ~/.profile or add it to the /etc/profile.d/cuda.sh file which
# you might have to create for all users (global):

# set PATH for cuda 11.2 installation
# if [ -d "/usr/local/cuda-11.2/bin/" ]; then
#     export PATH=/usr/local/cuda-11.2/bin${PATH:+:${PATH}}
#     export LD_LIBRARY_PATH=/usr/local/cuda-11.2/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
# fi

# Installation libcudnn8 8.0.4
# Adding the Repo:
# NOTE: The 20.04 repo from NVIDIA does not supply libcudnn but the 18.04 repo
# does and installs just fine into 20.04.
echo "deb http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64 /" | sudo tee /etc/apt/sources.list.d/cuda_learn.list

# Key installation:
sudo apt-key adv --fetch-keys  http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub

# System updating:
sudo apt update

# libcudnn 8.0.4 installations
sudo apt install libcudnn8

printf "\n---------------------------------------------------------------\n\n"
printf "Check carefully the installation logs above.\n\n"
printf "If all is well complete the installation by adding following paths to "
printf "\e[0;32m/etc/environment\e[m file:\n\n"
printf "\e[0;36mPATH\e[m='\e[0;36m\$PATH\e[m:/usr/local/cuda-11.2/bin'\n"
printf "\e[0;36mLD_LIBRARY_PATH\e[m='/usr/local/cuda-11.2/lib64'\n"
printf "\n"
