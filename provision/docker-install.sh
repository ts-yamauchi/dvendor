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

if [ ! -e /bin/git ]; then
yum install -y git
fi

if [ ! -e /usr/local/rbenv ]; then
echo "rbenvのインストールを行います..."
git clone git://github.com/sstephenson/rbenv.git /usr/local/rbenv
echo 'export RBENV_ROOT="/usr/local/rbenv"' >> /home/vagrant/.bash_profile
echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /home/vagrant/.bash_profile
echo 'eval "$(rbenv init -)"' >> /home/vagrant/.bash_profile
fi

if [ ! -e /usr/local/rbenv/plugins/ruby-build ]; then
git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build
yum install -y openssl-devel readline-devel zlib-devel sqlite-devel
fi

if [ ! -e /usr/local/rbenv/shims/ruby ]; then
echo $PATH
echo $RBENV_ROOT
source /home/vagrant/.bash_profile
/usr/local/rbenv/bin/rbenv install -v 2.3.3
/usr/local/rbenv/bin/rbenv global 2.3.3
fi

if [ ! -e /usr/local/rbenv/shims/rails ]; then
/usr/local/rbenv/shims/gem update
/usr/local/rbenv/shims/gem install rails
fi

