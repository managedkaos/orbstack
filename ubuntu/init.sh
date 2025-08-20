#!/bin/bash
apt-get update
apt-get upgrade -y
apt-get install -y \
  build-essential \
  ca-certificates \
  curl \
  git \
  gnupg \
  python3-dev \
  python3-pip \
  python3-venv \
  openjdk-21-jdk \
  unzip \
  wget \
  zip
sudo install -m 0755 -d /etc/apt/keyrings
sudo useradd -m -s /bin/bash demo
sudo echo "demo ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/demo
