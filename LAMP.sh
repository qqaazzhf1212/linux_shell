#!/bin/bash
#2020.5.18 15:51:22
#auto install LAMP
#by author lh
#Httpd define path variable
A_FILES="httpd-2.4.43.tar.bz2"
A_FILES_DIR="httpd-2.4.43"
A_URL="http://mirrors.cnnic.cn/apache/httpd/"
A_PREFIX="/usr/local/apache"

#MySql define path variable
M_FILES="mysql-5.5.20.tar.gz"
M_FILES_DIR="mysql-5.5.20"
M_URL="http://downloads.mysql.com/archives/mysql-5.5/"
M_PREFIX="/usr/local/mysql"

#PHP define path variable
P_FILES="php-5.3.28.tar.bz2"
P_FILES_DIR="php-5.3.28"
P_URL="http://mirrors.sohu.com/php/"
P_PREFIX="/usr/local/php5/"

echo -e '\033[32m----------------------------\033[0m'
echo 
if [ -z "$1" ];then
	echo -e "\033[36mPlease Select install Menu follow:\033[0m"
	echo -e "\033[32m1)编译安装Apache服务器\033[1m"
	echo -e "2)编译安装MySql服务器"
	echo -e "3)编译安装PHP服务器"
	echo -e "4)配置index.php并启动LAMP服务"
	echo -e "\033[31mUsage:{/bin/sh $0 1|2|3|4|help}\033[0m"
	exit 0
fi


if [[ "$1" -eq "help" ]];then
        echo -e "\033[36mPlease Select install Menu follow:\033[0m"
        echo -e "\033[32m1)编译安装Apache服务器\033[1m"
        echo -e "2)编译安装MySql服务器"
        echo -e "3)编译安装PHP服务器"
        echo -e "4)配置index.php并启动LAMP服务"
        echo -e "\033[31mUsage:{/bin/sh $0 1|2|3|4|help}\033[0m"
        exit 0
fi

#Install httpd web server
if [[ "$1" -eq "1" ]];then
	if [[ "$1" -eq "1" ]];then
        wget -c $A_URL/$A_FILES && tar -jxvf $A_FILES && cd $A_FILES_DIR
        sleep 10
    fi
	if [ $? -lt 0 ];then
        	make && make install
    else
    	echo "Apache Install faild,please check Apache Install"
    	exit 0
    fi
fi

#Install Mysql DB server
if [[ "$1" -eq "2" ]];then
		wget -c $M_URL/$M_FILES && tar -zvxf $M_PREFIX && cd $M_FILES_DIR
_INSTALL_PREFIX=$M_PREFIX \
-DMYSQL_UNIX_ADDR=/tmp/mysql.sock \
-DMYSQL_DATADIR=/data/mysql \
-DSYSCONFDIR=/etc \
-DMYSQL_USER=msyql \
-DMYSQL_TCP_PORT=3306 \
-DWITA_XTRADB_STORAGE_ENGINE=1 \
-DWITA_INNOBASE_STORAGE_ENGINE=1 \
-DWITA_PARTITION_STORAGE_ENGINE=1 \
-DWITA_BLACKHOLE_STORAGE_ENGINE=1 \
-DWITA_MYISAM_STORAGE_ENGINE=1 \
-DWITA_READLINE=1 \
-DENABLED_LOCAL_INFILE=1 \
-DWITA_EXTRA_CHARSETS=1 \
-DDEFAULT_CHARSET=utf8 \
-DDEFAULT_COLLATION=utf8_general_ci \
-DEXTRA_CHARSETS=all \
-DWITA_BIG_TABLES=1 \
-DWITA_DEBUG=0
make && make install
/bin/cp support-files/my-small.cnf /etc/my.cnf
/bin/cp support-files/mysql.server /etc/init.d/mysqld
chmod +x /etc/init.d/mysqld
chkconfig --add mysqld
chkconfig mysqld on 

if [ $? -eq 0 ];then
	make && make install
	echo -e '\n\033[32m----------------------------\033[0m'
			echo -e "\033[32mThe $M_FILES_DIR Server Install Success !\033[0m"
		else

			echo -e "\033[32mThe $M_FILES_DIR Make or Make install ERROR,Please Check\033[0m"

			exit 0
	fi
fi



##Install PHP server
if [[ "$1" -eq "3"  ]]
	wget -c $P_URL/$P_FILES && tar -jxvf &P_FILES && cd $P_FILES_DIR && ./configure --prefix==
$P_PREFIX --with-config-file-path=$P_PREFIX/etc --with-mysql=$M_PREFIX --with-apxs2=$A_PREFIX/bin/with-apxs
	if [ $? -eq 0 ];then
		make ZEND_EXTAR_LIBS='-liconv' && make install
		echo -e "\n\033[32m----------------------------\033[0m"
		echo -e "\033[32mThe $P_FILES_DIR Server Install Success !\033[0m"
	else
		echo -e "\033[32mThe $P_FILES_DIR Make or Make install ERROR,Please Check\033[0m"
		exit 0
	fi
fi
if [[ "$1" -eq "4" ]];then
	sed -i "/DirectoryIndex/s/index.html/index.php index.html/g" $A_PREFIX/conf/httpd.conf
	$A_PREFIX/bin/apachectl restart
	echo "AddType  application/x-httpd-php.php" >> $A_PREFIX/conf/httpd.conf
	IP= ifconfig eth1|grep "Bcast" |awk '{print $2}'|cut -d: -f2
	echo "you can access http://$IP"	
cat > $A_PREFIX/htdocs/index.php <<EOF
<?php
phpinfo();
?>
EOF
fi






