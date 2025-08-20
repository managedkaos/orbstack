#!/bin/bash

# Set ulimit so core dumps are generated
ulimit -c unlimited

# Install required packages
yum install -y \
    epel-release \
    git \
    wget \
    zip \
    unzip \
    vim \
    python3-pip

sudo useradd -m -s /bin/bash demo
sudo echo "demo ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/demo

