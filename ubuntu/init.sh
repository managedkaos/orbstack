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
  wget
sudo install -m 0755 -d /etc/apt/keyrings
