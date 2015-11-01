#!/bin/bash

. /gozer/common/common.sh

cat <<EOF >/dev/shm/up
${BASTION_ID}
${VPN_PASSWORD}
EOF
chown gozer:gozer /dev/shm/up
chmod 600 /dev/shm/up

openvpn --config /gozer/client/config --remote ${VPN_REMOTE} 1194
