#!/bin/bash
set -eux

################
## Base system

# Disable SELinux
/sbin/getenforce | grep -i disabled || /sbin/setenforce 0
sed -i s/SELINUX=enforcing/SELINUX=disabled/g /etc/sysconfig/selinux /etc/selinux/config

# Enable external YUM repos
rpm -q epel-release || yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -q mysql-community-release || yum -y install https://repo.mysql.com/mysql-community-release-el7.rpm

# System update
yum -y update

# Useful utilities
sudo yum -y install htop vim sysstat nc expect pwgen


########################
## Install MySQL server
yum -y install mysql-community-server


##########################
## Services configuration

# Enable services
sudo systemctl enable  mysqld

# Start services
sudo systemctl restart mysqld

###########################
## Firewalld configuration
if [ $(which firewalld) ]; then 
   firewall-cmd --add-service=mysql
   firewall-cmd --permanent --add-service=mysql
else
   echo "There isn't firewall installed"
fi


#######################
## MySQL Configuration

if [ -f /root/.mylogin.cnf ]; then
   echo "MySQL user config already exists"
else
   cp $MYSQLHELPER /var/lib/mysql/.root-password.expect -L
   expect /var/lib/mysql/.root-password.expect $(grep -i 'A temporary password' /var/log/mysqld.log | awk '{print $NF}') $(pwgen -1Bc 4).$(pwgen -1nB 4)-$(pwgen -1nB 4)_$(pwgen -1nB 4)
rm -f /var/lib/mysql/.root-password.expect
fi


