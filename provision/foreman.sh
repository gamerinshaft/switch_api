#!/usr/bin/env bash

version="0.78.0"

source /usr/local/share/chruby/chruby.sh
chruby $(cat ~/.ruby-version)

if [[ ! -d ${GEM_HOME}/gems/rails-${version}/ ]]; then
  gem install foreman --version=${version} --no-ri --no-rdoc --verbose
fi
