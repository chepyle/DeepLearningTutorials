#!/bin/bash -e
# Simple setup.sh for configuring Ubuntu EC2 instance
# for headless setup. Only needs to be run once after instance creation
# PART 2 - after the reboot!

# from http://markus.com/install-theano-on-aws/

cuda-install-samples-7.0.sh ~/

cd NVIDIA\_CUDA-7.0\_Samples/1\_Utilities/deviceQuery  
make  
./deviceQuery

echo -e "\n[global]\nfloatX=float32\ndevice=gpu\n[mode]=FAST_RUN\n\n[nvcc]\nfastmath=True\n\n[cuda]\nroot=/usr/local/cuda" >> ~/.theanorc  

# assuming the train.zip.00* and test.zip.00* files are in the home directory, combine them:

cat ~/train.zip.* > ~/train.zip
cat ~/test.zip.* > ~/test.zip

# unzip da files
unzip train.zip
unzip test.zip
