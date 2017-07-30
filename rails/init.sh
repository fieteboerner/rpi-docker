#!/bin/bash

for SCRIPT in /var/app/profile.d/*;
  do source $SCRIPT;
done

/usr/local/bin/bundler exec puma -C config/puma.rb
