#!/bin/bash
set -a
set -e

/sbin/ip addr show tun0 | awk '/inet/ {print $2}' > /gozer/state/ip
