#!/bin/bash
STD="\033[0;0;39m"
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
# Recorde to database
if [[ ${CENTRAL_DATABASE_ADDRESS} == "" ]]
then
        CENTRAL_DATABASE_ADDRESS=`cat /coreui/.env|grep COMMDB_DATABASE_ADDRESS|awk -F'=' '{print $2}'`
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
SQL="select score, uid from top_record where id = 'GLOBAL_MINE_14' and uid = '$1' "
#SQL="select  concat(min(t.name), 'SSS', t.serverid)  from (select s."name",  c.serverid  from server_list  s, cluster_ids c where s.cluster = c."cluster" order by c.serverid) as  t  group by t.serverid"
echo $SQL 2222222222222222222
#INFO=`/usr/bin/psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -A -t -c "${SQL}"|jq '.[]|.name'|sed 's/"//g'`

INFO=`/usr/bin/psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -A -t -c "${SQL}"`
echo $INFO
#exit
if [ "$1" = "" ];then
	echo "need uid"
	exit
fi


if [ "$2" = "" ];then
	echo "need score"
	exit
fi

