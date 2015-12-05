#!/bin/bash

version="2.2.2"

if [[ ! -d /opt/rubies/ruby-${version}/ ]]; then
  /usr/local/bin/ruby-install ruby $version
  /opt/rubies/ruby-${version}/bin/gem update --system --verbose
fi

su vagrant -c "
  echo ${version} > ~/.ruby-version
  echo ${version} > /vagrant/.ruby-version
"
