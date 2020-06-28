#!/bin/bash
#2020.6.21 10:50:55
#auto backup mysql db
#by author lh
##################

SQL_CMD="/usr/bin/mysqldump"
SQL_USER="root"
SQL_PWD="123456"
SQL_HOST="127.0.0.1"
SQL_DBS="$*"
SQL_DIR="/data/backup/data"
SQL_DATE=`date +"%Y-%m-%d %H:%M:%S"`

if [ ! -d $SQL_DIR ];then
	mkdir -p $SQL_DIR
fi

for SQL_DB in `echo $SQL_DBS`
do
if [ $SQL_DB == "all" ];then
	$SQL_CMD -h $SQL_HOST -u$SQL_USER -p$SQL_PWD --all-databases  >${SQL_DIR}/${SQL_DB}${SQL_DATE}.sql
	if [ $? -eq  0 ];then
        	echo -e "\033[32m------------------------\033[0m"
        	echo -e "\033[32m $SQL_DB backup success.\033[0m"
        	exit 0
	else    
        	echo -e "\033[32m------------------------\033[0m"
        	echo -e "\033[32m The $SQL_DB backup failed .Please check $SQL_DB backup\033[0m"
        	exit 1
	fi

else
	$SQL_CMD -h $SQL_HOST -u$SQL_USER -p$SQL_PWD $SQL_DB  >${SQL_DIR}/${SQL_DB}${SQL_DATE}.sql
	if [ $? -eq  0 ];then
		echo -e "\033[32m------------------------\033[0m"
		echo -e "\033[32m $SQL_DB backup success.\033[0m"
		exit 0
	else
		echo -e "\033[32m------------------------\033[0m"
		echo -e "\033[32m The $SQL_DB backup failed .Please check $SQL_DB backup\033[0m"
		exit 1
	fi
fi
done


