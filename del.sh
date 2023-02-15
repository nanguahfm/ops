#!/bin/bash
for x in `cat x1.txt`
do
	redis-cli -h ca001-central-guild2.bdct0f.ng.0001.usw2.cache.amazonaws.com  -p 6379 del $x  >> del1.txt
	echo $x >> del1.txt
done
