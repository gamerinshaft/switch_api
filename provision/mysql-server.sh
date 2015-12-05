#!/bin/bash

password="password"

if [[ ! -f /usr/sbin/mysqld ]]; then
  rpm -Uvh http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
  sed -i -e "19c enabled=1" /etc/yum.repos.d/mysql-community.repo
  sed -i -e "27c enabled=0" /etc/yum.repos.d/mysql-community.repo
  yum install -y mysql-server mysql-devel
  service mysqld start
  chkconfig mysqld on
  mysql -u root -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${password}')"
fi
