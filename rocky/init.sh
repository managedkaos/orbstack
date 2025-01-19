#!/bin/bash
ulimit -c unlimited
yum install -y varnish nginx git wget zip unzip
sed -i 's/80/8080/' /etc/nginx/nginx.conf
systemctl enable --now varnish nginx
sleep 1
curl -s http://localhost:6081 | grep Nginx
