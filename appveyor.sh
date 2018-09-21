#!/bin/bash

set -ev

echo ha
export APPVEYOR_SSH_BLOCK=true
touch ~/build.lock
curl -sflL 'https://raw.githubusercontent.com/appveyor/ci/master/scripts/enable-ssh.sh' | bash -e -
echo ja