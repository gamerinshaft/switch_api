#!/bin/bash

version="0.3.8"

if [[ -d /usr/local/share/chruby ]]; then
  source /usr/local/share/chruby/chruby.sh
  current_version=$(chruby --version)
fi

if [[ "${current_version}" != "chruby: ${version}" ]]; then
  mkdir -p /opt/src
  cd /opt/src
  wget -O chruby-${version}.tar.gz \
    https://github.com/postmodern/chruby/archive/v${version}.tar.gz
  tar xzf chruby-${version}.tar.gz
  cd chruby-${version}/
  make install
  cd ..
  rm chruby-${version}.tar.gz
  rm -r chruby-${version}/
fi

if [ $(grep -c chruby.sh ~vagrant/.bashrc) -eq 0 ]; then
  echo 'source /usr/local/share/chruby/chruby.sh' >> ~vagrant/.bashrc
fi

if [ $(grep -c auto.sh ~vagrant/.bashrc) -eq 0 ]; then
  echo 'source /usr/local/share/chruby/auto.sh' >> ~vagrant/.bashrc
fi
