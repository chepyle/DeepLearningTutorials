#!/bin/bash -e
# Simple setup.sh for configuring Ubuntu EC2 instance
# for headless setup. Only needs to be run once after instance creation. Still alpha!
# PART 2 - after the reboot!

# from https://github.com/BVLC/caffe/wiki/Install-Caffe-on-EC2-from-scratch-(Ubuntu,-CUDA-7,-cuDNN)

sudo apt-get install linux-source
sudo apt-get install linux-headers-`uname -r`

sudo ~/nvidia_installers/NVIDIA-Linux-x86_64-346.46.run

'''
Accept the license agreement.
If you see: "nvidia-installer was forced to guess the X library path '/usr/lib' and X module path ..." go ahead anc click OK.
If you see "The CC version check failed" then click "Ignore CC version check".
I said no to DKMS kernel registration
It may ask you about 32-bit libraries, I selected to yes, install them.
It will ask you about running nvidia-xconfig to update your X configuration file. I selected no.
Run nvidia-smi to view the installed GPUs.
'''

sudo modprobe nvidia
sudo apt-get install build-essential
sudo ~/nvidia_installers/cuda-linux64-rel-7.0.28-19326674.run
sudo ~/nvidia_installers/cuda-samples-linux-7.0.28-19326674.run

'''
Sometimes it is not necessary to reinstall build-essential.
When the license agreement appears, press q so you dont have to scroll down.
Accept the EULA.
Use the default path by pressing enter.
Would you like to add desktop menu shortcuts? Answer depends on your preference.
Would you like to create a symbolic link? Enter yes.
It will now install CUDA.

'''
echo -e "\nexport PATH=$PATH:/usr/local/cuda-7.0/bin\nexport LD_LIBRARY_PATH=:/usr/local/cuda-7.0/lib64" >> .bashrc  

source ~/.bashrc

'''
After registering with NVIDA, download cuDNN. Extract the tar and copy the headers and libraries to the CUDA directory.
'''
tar -zxf cudnn-6.5-linux-x64-v2.tgz
cd cudnn-6.5-linux-x64-v2
sudo cp lib* /usr/local/cuda/lib64/
sudo cp cudnn.h /usr/local/cuda/include/

# install bleeding-edge theano:
git clone git://github.com/Theano/Theano.git
cd Theano
python setup.py develop --user
cd ~

# get some sweet pylearn2: (http://deeplearning.net/software/pylearn2/#download-and-installation)
git clone git://github.com/lisa-lab/pylearn2.git
cd pylearn2
sudo python setup.py develop

# an important bit from http://markus.com/install-theano-on-aws/ :
echo -e "\n[global]\nfloatX=float32\ndevice=gpu\n[mode]=FAST_RUN\n\n[nvcc]\nfastmath=True\n\n[cuda]\nroot=/usr/local/cuda" >> ~/.theanorc  

# assuming the train.zip.00* and test.zip.00* files are in the home directory, combine them:

cat ~/train.zip.* > ~/train.zip
cat ~/test.zip.* > ~/test.zip

# unzip da files
unzip train.zip
unzip test.zip

