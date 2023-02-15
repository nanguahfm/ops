#!/bin/bash
z=0
for x in `head -60000 134.txt`
do
	echo $x
	((z=z+1))
	echo $z
	y=`redis-cli -h mh-region134-002.bdct0f.ng.0001.usw2.cache.amazonaws.com -p 6379 SMEMBERS $x`
	redis-cli -h ca001-region134.bdct0f.ng.0001.usw2.cache.amazonaws.com  -p 6379  sadd ${x}  $y
	
done
