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
