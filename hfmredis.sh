#!/bin/bash
for x in {1..141}
do
	echo $x
	region=$x
	if [ $x -lt 61 ]; then
		region="-"${x}
	fi
	echo server-${region} cmd[$1] >> redis.txt
	redis-cli -h ca001-region${region}.bdct0f.ng.0001.usw2.cache.amazonaws.com -p 6379 $1  >> redis.txt  2>&1
	#echo $region
done

xx="66-68
55-57
52-53
58-60
49-51
61-63
69-71
64-65
72-73
27-28
24-25
46-48
32-33
44-45
6-10
1-5"
for x in $xx
do
	echo $x
	region=$x
	echo server-${region} cmd[$1] >> redis.txt
	redis-cli -h ca001-region${region}.bdct0f.ng.0001.usw2.cache.amazonaws.com -p 6379 $1 >> redis.txt
done
