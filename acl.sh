#!/bin/bash

while true; do
  now=$(date '+%Y-%m-%d %H:%M:%S')
  echo "Current time: $now"
  redis-cli -h ca001-central-1.bdct0f.ng.0001.usw2.cache.amazonaws.com  -p 6379 del ACL_UNIQ_ACL_TOTAL_UNIQ_FRIEND
  sleep 60
done
