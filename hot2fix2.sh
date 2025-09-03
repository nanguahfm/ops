#!/bin/bash
STD="\033[0;0;39m"
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
# Recorde to database
if [[ ${CENTRAL_DATABASE_ADDRESS} == "" ]]
then
        CENTRAL_DATABASE_ADDRESS=`cat /coreui/.env|grep CENTRAL_DATABASE_ADDRESS|awk -F'=' '{print $2}'`
fi
export dbinfo=(`echo ${CENTRAL_DATABASE_ADDRESS}|tr ':' ' '`);
export USER=${dbinfo[0]} PORT=`echo ${dbinfo[2]}|awk -F/ '{print $1}'` DATABASE=`echo ${dbinfo[2]}|awk -F/ '{print $2}'`;
export HOST=`echo ${dbinfo[1]}|awk -F'@' '{print $2}'`;
export PGPASSWORD=`echo ${dbinfo[1]}|awk -F'@' '{print $1}'`;

# Get Online num
#ONLINE=`/usr/bin/curl -s "http://localhost:8888/get_online"`
NOW=`date '+%s'`
#echo -e "$YELLOW ${GAMEOPS_DATABASE_ADDRESS}$STD"
#SQL="select array_to_json(array_agg(row_to_json(t))) as array_to_json from (select name from server_list) t"
SQL="select concat(s."name", 'SSS', s.cluster) from server_list  s where s.cluster like '%$1%' order by s.cluster"
#SQL="select  concat(min(t.name), 'SSS', t.serverid)  from (select s."name",  c.serverid  from server_list  s, cluster_ids c where s.cluster = c."cluster" order by c.serverid) as  t  group by t.serverid"
#echo $SQL
#INFO=`/usr/bin/psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -A -t -c "${SQL}"|jq '.[]|.name'|sed 's/"//g'`

INFO=`/usr/bin/psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -A -t -c "${SQL}"`
#echo $INFO
#exit
if [ "$1" = "" ];then
	echo "need server id"
	exit
fi
SERVER=$1
echo SERVER:[$SERVER]
echo "------------------------------"
for XXX in $INFO
do
	#echo $XXX
	SID=${XXX##*SSS}
	POD=${XXX%%SSS*}
	#echo $POD
        PODIP=`echo $POD|awk -F':' '{print $1}'`
        PODPORT=`echo $POD|awk -F':' '{print $2}'`
        PODPORT=`echo "$PODPORT + 1"|bc`
        echo -e  $GREEN $PODIP:$PODPORT $STD  $SID 
	EXEC=0
	if [[ $SID =~ .*$SERVER.* ]];then
		EXEC=1
	fi
	if [[ $SID == $SERVER ]];then
		EXEC=1
	fi
	if [ $EXEC -eq 1 ];then
		echo -e $RED EXEC SERVER $SID $STD
		#for TOP in `cat top.txt`
		#do
		POST="{\"funcs\" :[\"server/server.CustomizeBoxUseV2\"，\"server/server.IsSameAdvancedArenaFormationPattern\"],\"so\" : \"3b25fa38\",\"set\" :1,\"hot\" : \"gamefix2\",\"safe\" : 1,\"clean\" : 0,\"fix\" : 0}"
			#echo $POST
        		/usr/bin/curl -s --max-time 50 -d"$POST"  http://$PODIP:$PODPORT/debug/debughotfix
		#done
	fi
	#for TOP in `cat top.txt`
	#do
	#	POST="{\"set\" : 1,\"top\" : \"$TOP.$SID\",\"limit\" : 30}"
	#	echo $POST
        #	/usr/bin/curl -s --max-time 5 -d"$POST" http://$PODIP:$PODPORT/debug/flushtop
	#done
        #/usr/bin/curl -s --max-time 5 -d'{"set":0, "notme":-1}' http://$PODIP:$PODPORT/debug/regionslave
        echo "<br>------------------<br>"
done

