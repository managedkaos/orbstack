#!/bin/bash
apt-get update
apt-get upgrade -y
apt-get install -y \
  build-essential \
  ca-certificates \
  curl \
  git \
  gnupg \
  man \
  python3-dev \
  python3-pip \
  python3-venv \
  openjdk-21-jdk \
  unzip \
  wget \
  zip

sudo install -m 0755 -d /etc/apt/keyrings

password=$(openssl passwd -6 "demo")

sudo useradd -m -s /bin/bash demo
sudo echo "demo ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/demo
sudo usermod -p ${password} demo

sudo useradd -m -s /bin/bash Michael.Jenkins
sudo echo "Michael.Jenkins ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/Michael.Jenkins
sudo usermod -p ${password} Michael.Jenkins
