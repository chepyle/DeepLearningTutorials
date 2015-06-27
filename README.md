#Quick Start

--Launch an Amazon EC2 GPU instance (g2.2xlarge), spot instance price is usually <0.20 USD. Be sure to select the availability zone when creating the instance in order to get the best available rate.  Some (very under-tested) scripts should encapsulate the setup process:

--Once logged in, enter the command:
`curl https://raw.githubusercontent.com/chepyle/DeepLearningTutorials/master/setup_1.sh | sh`

-- the instance will reboot, then from the home directory run 
`./DeepLearningTutorials/setup_2.sh`

-- once installed, do a `screen` then use utilities like `top` and `watch nvidia-smi` to check on progress

#Deep Learning Tutorials


Deep Learning is a new area of Machine Learning research, which has been
introduced with the objective of moving Machine Learning closer to one of its
original goals: Artificial Intelligence.  Deep Learning is about learning
multiple levels of representation and abstraction that help to make sense of
data such as images, sound, and text.  The tutorials presented here will
introduce you to some of the most important deep learning algorithms and will
also show you how to run them using Theano.  Theano is a python library that
makes writing deep learning models easy, and gives the option of training them
on a GPU.

The easiest way to follow the tutorials is to `browse them online
<http://deeplearning.net/tutorial/>`_.

`Main development <http://github.com/lisa-lab/DeepLearningTutorials>`_
of this project.

.. image:: https://secure.travis-ci.org/lisa-lab/DeepLearningTutorials.png
   :target: http://travis-ci.org/lisa-lab/DeepLearningTutorials

##Project Layout

Subdirectories:

- code - Python files corresponding to each tutorial
- data - data and scripts to download data that is used by the tutorials
- doc  - restructured text used by Sphinx to build the tutorial website
- html - built automatically by doc/Makefile, contains tutorial website
- issues_closed - issue tracking
- issues_open - issue tracking
- misc - administrative scripts


##Build instructions

To build the html version of the tutorials, install sphinx and run doc/Makefile
