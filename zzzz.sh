#!/bin/bash
SU='"The Crusade of Edda" event starting soon!'
BODY=`cat mail1.txt`
SID=11
NB=${BODY/\"SID\"/$SID}
echo $NB > nb.json
sleep 5
/usr/bin/curl -d@nb.json http://10.128.58.111:7350/v1/igg/mail