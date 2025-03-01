#!/bin/bash


ACCOUNT_FILE="accounts.txt"
SQL_FILE="your_script.sql"


if [[ ! -f "$ACCOUNT_FILE" ]]; then
    echo "账号文件不存在: $ACCOUNT_FILE"
    exit 1
fi

if [[ ! -f "$SQL_FILE" ]]; then
    echo "SQL 文件不存在: $SQL_FILE"
    exit 1
fi


while IFS=' ' read -r username password host port dbname
do

    [[ -z "$username" || -z "$password" || -z "$host" || -z "$port" || -z "$dbname" ]] && continue

    echo "正在连接数据库: $dbname ($host:$port) 用户: $username"


    PGPASSWORD="$password" psql -h "$host" -p "$port" -U "$username" -d "$dbname" -f "$SQL_FILE" -w

    if [[ $? -eq 0 ]]; then
        echo "SQL 执行成功: $dbname"
    else
        echo "SQL 执行失败: $dbname"
    fi

    echo "----------------------------------"

done < "$ACCOUNT_FILE"

echo "所有数据库执行完毕"
