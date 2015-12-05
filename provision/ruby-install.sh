#!/bin/bash

version="0.4.1"

if [[ -f /usr/local/bin/ruby-install ]]; then
  current_version=$(ruby-install --version)
fi

if [[ "${current_version}" != "ruby-install: ${version}" ]]; then
  mkdir -p /opt/src
  cd /opt/src
  wget -O ruby-install-${version}.tar.gz \
    https://github.com/postmodern/ruby-install/archive/v${version}.tar.gz
  tar xzf ruby-install-${version}.tar.gz
  cd ruby-install-${version}/
  make install
  cd ..
  rm ruby-install-${version}.tar.gz
  rm -r ruby-install-${version}/
fi
