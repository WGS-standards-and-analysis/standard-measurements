#!/bin/bash

# Run all tests in this directory

set -e

function logmsg(){
  echo "$(basename $0): $@" >&2
}

for script in $(dirname $0)/*.sh; do
  if [ "$script" == "$0" ]; then
    continue;
  fi
  
  logmsg "Running unit test script $script"
  bash $script
  echo
done
