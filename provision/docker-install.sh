#!/bin/bash


if [ ! -e /etc/yum.repos.d/docker.repo ]; then

echo "Dockerのインストールを行います..."

yum update -y

tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/$releasever/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF

fi


if [ ! -e /usr/bin/docker-compose ]; then

echo "docker-composeのインストールを行います..."

yum install -y docker-engine

chkconfig docker on

curl -L https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m` > /usr/bin/docker-compose
chmod +x /usr/bin/docker-compose

fi