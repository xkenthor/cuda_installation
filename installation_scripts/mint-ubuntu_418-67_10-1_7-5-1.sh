#!/bin/bash
# Nvidia driver 440 (?418.67), cuda 10.1 & cudnn 7.5.1 installation for
# Ubuntu 18.04, Linux Mint.
# -
# [27.01.2021]: Taken from:
# https://askubuntu.com/questions/1077061/how-do-i-install-nvidia-and-cuda-drivers-into-ubuntu
# Created: 30.10.2020
# Last updated: 07.01.2021

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
sudo apt-install nvidia-driver-440

# Installing the key.
sudo apt-key adv --fetch-keys  http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub

# Adding the repos.
sudo bash -c 'echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/cuda.list'
sudo bash -c 'echo "deb http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/cuda_learn.list'

# Updating system again.
sudo apt update

# Installation CUDA 10.1.
sudo apt install cuda-10-1

# It should be installing the NVIDIA 418.40 drivers with it as those are what
# are listed in the repo. See:
# http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/

# Install libcudnn7 7.5.1:
sudo apt install libcudnn7

# POST-ACTIONS - TUNE ENVIRONMENT AND REBOOT
# setting PATH for cuda 10.1 installation
# if [ -d "/usr/local/cuda-10.1/bin/" ]; then
#     export PATH=/usr/local/cuda-10.1/bin${PATH:+:${PATH}}
#     export LD_LIBRARY_PATH=/usr/local/cuda-10.1/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
# fi

printf "\n---------------------------------------------------------------\n\n"
printf "To complete the installation add following paths to "
printf "\e[0;32m/etc/environment\e[m file:\n\n"
printf "\e[0;36mPATH\e[m='\e[0;36m\$PATH\e[m:/usr/local/cuda-10.1/bin'\n"
printf "\e[0;36mLD_LIBRARY_PATH\e[m='/usr/local/cuda-10.1/lib64'\n"
printf "\n"

# Author notes:
#
#     2021-01-07: Please use the 20.04 installation below moving forward as
#     the steps are the same for both 18.04 and 20.04.
#
#     2019-06-23: Recent updates with either the CUDA 10.0 or 10.1 versions
#     the NVIDIA 418.67 driver, that installs with it, no longer has the 32bit
#     libraries included and this will cause Steam and most games to no longer
#     work. The version of libnvidia-gl-418:i386 only installs the 418.56
#     version which will not work with the 418.67 driver. Hopefully NVIDIA will
#     release an update for that soon. I have added the info at the bottom of
#     this answer in the .run file install part of how to download just the run
#     file for the CUDA installer then you can use whatever driver you want.
#     The run file is 2.3GB in size, so it might take a bit to download.
#
#     CUDA 9.x is not available through NVIDIA's ubuntu1804 repo. I did however
#     write an answer for CUDA 9.2 at https://askubuntu.com/a/1086993/231142.
