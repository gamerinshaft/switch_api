#!/bin/bash

if [[ ! -d /usr/lib/postgresql/9.3/ ]]; then
  rpm -Uvh http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-1.noarch.rpm
  yum install -y postgresql93-server postgresql-devel
  service postgresql-9.3 initdb
  service postgresql-9.3 start
  chkconfig postgresql-9.3 on
  su - postgres -c "
    psql -c \"UPDATE pg_database SET datistemplate=false WHERE datname='template1'\"
    psql -c \"DROP DATABASE template1\"
    psql -c \"CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8'\"
    psql -c \"UPDATE pg_database SET datistemplate=true WHERE datname='template1'\"
    createuser -d -S -R vagrant
  "
fi
