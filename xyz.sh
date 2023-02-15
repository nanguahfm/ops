#!/bin/bash
while true
do
echo `date` >> xyz.log
./lang.sh >> xyz.log
sleep 400
done
