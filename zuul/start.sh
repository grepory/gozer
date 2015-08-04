#!/bin/bash

# KEY_URL from environment
if [ -z "$KEY_URL" ]; then 
  echo "Must supply KEY_URL environment variable."
  exit 1
fi

/s3kms get $KEY_URL > /etc/ssh/ssh_dsa_host_key

