#!/usr/bin/env bash

sudo rpm --import http://rpms.famillecollet.com/RPM-GPG-KEY-remi
sudo rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm

sudo yum -y install redis --enablerepo=remi
sudo chkconfig redis on
sudo service redis start
