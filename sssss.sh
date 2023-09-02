#!/bin/bash
while IFS=$'\t' read -r uuid zone; do
    echo "UUID: $uuid" "Zone: $zone"
    
done < soulhall.txt