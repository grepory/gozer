#!/bin/bash

. /gozer/common/common.sh

get_encrypted_object dev/opsee-key.pem /gozer/state/server.key
get_encrypted_object dev/opsee.crt /gozer/state/server.crt

if [ -z "$1" ]; then
  echo "Must specify a /24 network to start a server."
  exit 1
fi

/usr/sbin/openvpn --config /gozer/server/config --auth-user-pass-verify "/gozer/bin/auth -u ${AUTH_URL}" via-file --server $1 255.255.255.0
