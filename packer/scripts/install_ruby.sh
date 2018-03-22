#!/usr/bin/env bash

set -e

# Install Ruby
apt-get update
apt-get -y upgrade
apt-get -y install ruby-full ruby-bundler build-essential
gem install bundler
