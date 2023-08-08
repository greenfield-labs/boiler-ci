#!/usr/bin/env bash
pushd . > /dev/null
cd /app/
bundle exec ruby /app/action.rb
popd > /dev/null
