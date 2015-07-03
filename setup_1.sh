#!/bin/bash -e
# Simple setup.sh for configuring Ubuntu EC2 instance
# for headless setup. Only needs to be run once after instance creation.  Still alpha!

# Install basics
sudo apt-get update && apt-get install build-essential

sudo apt-get install -y git g++ libopenblas-dev ipython-notebook gcc gfortran wget linux-image-generic parallel python-pip python-dev ipython unzip zlibc zlib1g zlib1g-dev lynx libjpeg-dev python-numpy python-scipy python-nose python-joblib python-skimage python-h5py  imagemagick


# Install emacs24
# https://launchpad.net/~cassou/+archive/emacs
sudo add-apt-repository -y ppa:cassou/emacs
sudo apt-get -qq update
sudo apt-get install -y emacs24-nox emacs24-el emacs24-common-non-dfsg

# get my other config script
git clone https://github.com/chepyle/dotfiles.git
ln -sb dotfiles/.screenrc .
ln -sf dotfiles/.emacs.d .
ln -sb dotfiles/.bash_profile .
ln -sb dotfiles/.bashrc .
ln -sb dotfiles/.bashrc_custom .

# get project specific repo
git clone https://github.com/chepyle/DeepLearningTutorials


# update NVIDIA driver
# http://markus.com/install-theano-on-aws/ ** interesting, but I had problems getting it to work, try instead:
# https://github.com/BVLC/caffe/wiki/Install-Caffe-on-EC2-from-scratch-(Ubuntu,-CUDA-7,-cuDNN)
wget http://developer.download.nvidia.com/compute/cuda/7_0/Prod/local_installers/cuda_7.0.28_linux.run

chmod +x cuda_7.0.28_linux.run
mkdir nvidia_installers
./cuda_7.0.28_linux.run -extract=`pwd`/nvidia_installers

sudo apt-get install linux-image-extra-virtual

'''
Important: While installing the linux-image-extra-virtual, you may be prompted "What would you like to do about menu.lst?" I selected "keep the local version currently installed"
'''

sudo cp ~/DeepLearningTutorials/nouveau-kms.conf /etc/modprobe.d/blacklist-nouveau.conf

echo options nouveau modeset=0 | sudo tee -a /etc/modprobe.d/nouveau-kms.conf
sudo update-initramfs -u
sudo reboot

