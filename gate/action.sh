#!/usr/bin/env sh
owd=$(pwd)
cd /app/
bundle exec ruby /app/action.rb
cd $owd
