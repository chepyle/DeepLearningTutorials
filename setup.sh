#!/bin/bash -e
# Simple setup.sh for configuring Ubuntu EC2 instance
# for headless setup. Only needs to be run once after instance creation

# Install basics

sudo apt-get install -y git python-pip python-dev ipython unzip zlibc zlib1g zlib1g-dev lynx libjpeg-dev

# Install emacs24
# https://launchpad.net/~cassou/+archive/emacs
sudo add-apt-repository -y ppa:cassou/emacs
sudo apt-get -qq update
sudo apt-get install -y emacs24-nox emacs24-el emacs24-common-non-dfsg

# get my other config script
git clone https://github.com/chepyle/dotfiles.git
ln -sb dotfiles/.screenrc .
ln -sf dotfiles/.emacs.d .

# get project specific repo
git clone https://github.com/chepyle/datascience-bowl
# move nouveau blacklist config file for NVIDIA driver install
sudo cp ~/DeepLearningTutorials/nouveau-kms.conf /etc/modprobe.d/nouveau-kms.conf

# update NVIDIA driver
#http://tleyden.github.io/blog/2014/10/25/cuda-6-dot-5-on-aws-gpu-instance-running-ubuntu-14-dot-04/
wget http://us.download.nvidia.com/XFree86/Linux-x86_64/346.47/NVIDIA-Linux-x86_64-346.47.run

sudo apt-get install -y linux-image-extra-virtual

echo options nouveau modeset=0 | sudo tee -a /etc/modprobe.d/nouveau-kms.conf

sudo update-initramfs -u

# reboot
sudo reboot

