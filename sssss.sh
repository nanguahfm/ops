#!/bin/bash
while IFS=$'\t' read -r uuid zone; do
    echo "UUID: $uuid" "Zone: $zone"
    redis-cli  -h ca001-central-1.bdct0f.ng.0001.usw2.cache.amazonaws.com -p 6379 zscore $zone $uuid
	redis-cli  -h ca001-central-1.bdct0f.ng.0001.usw2.cache.amazonaws.com -p 6379 zadd  $zone 29760306401831 $uuid
	redis-cli  -h ca001-central-1.bdct0f.ng.0001.usw2.cache.amazonaws.com -p 6379 zscore $zone $uuid
done < soulhall.txt