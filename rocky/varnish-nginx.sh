#!/bin/bash

# Set ulimit so core dumps are generated
ulimit -c unlimited

# Install required packages
yum install -y \
    epel-release \
    varnish \
    nginx \
    git \
    wget \
    zip \
    unzip \
    vim \
    python3-pip \
    awscli

# Change the default port of Nginx to 8080
sed -i 's/80/8080/' /etc/nginx/nginx.conf

# Start and enable Varnish and Nginx
systemctl enable --now varnish nginx

# Take a break :D
sleep 1

# Check if Varnish is working
curl -s http://localhost:6081 | \
    grep Nginx && \
    echo "Varnish is working" || echo "Varnish is not working"
