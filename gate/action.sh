#!/usr/bin/env sh
owd=$(pwd)
cd /app/
echo "calling bundle exec ruby action.rb"
bundle exec ruby /app/action.rb
cd $owd
