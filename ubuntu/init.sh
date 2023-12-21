#!/bin/bash
apt-get update
apt-get upgrade -y
apt-get install -y ca-certificates curl gnupg wget git
sudo install -m 0755 -d /etc/apt/keyrings

