#!/bin/bash
# set -x
set -a

echo "Setting up runtime..."

if [ ! -d /gozer/state ]; then
  mkdir -p /gozer/state
fi

AWS=$(curl --connect-timeout 2 http://169.254.169.254/latest/meta-data/ 2>&1 /dev/null; echo $?)
if [[ $AWS == 0 ]]; then
  eval "$(/opt/bin/ec2-env)"
fi

get_encrypted_object() {
  local bucket=opsee-keys
  local obj=$1
  local target=$2

  echo "Copying ${obj} from KMS to ${target} locally."

  if [ -z "$obj" ] || [ -z "$target" ]; then
    echo "get_object requires two arguments"
    exit 1
  fi

  s3kms -r "us-west-1" get -b $bucket -o $obj > $target
  chmod 600 $target
  if [ ! -r $target ]; then
    echo "Unable to read $target"
    exit 1
  fi
}

# get_encrypted_object dev/ca.crt /gozer/state/ca.crt
curl -Lo /gozer/state/ca.crt https://s3-us-west-1.amazonaws.com/opsee-public-keys/ca.crt
# get_encrypted_object dev/tls-auth.key /gozer/state/tls-auth.key
