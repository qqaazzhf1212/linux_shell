#/bin/bash
#2020年1月12日11:22:40
#auto install apache web v2
#by author lh
###########################
APACHE_DIR="/usr/local/apache"
APACHE_VER="2.4.43"
APACHE_SOFT="httpd-${APACHE_VER}.tar.bz2"
APACHE_URL="https://mirrors.tuna.tsinghua.edu.cn/apache/httpd"
APACHE_ARG="--enable-so --enable-rewrite --enable-proxy --enable-ssl"


yum install -y wget bzip2 bzip2-devel tar make zlib-devel
yum install -y gcc gcc-c++ apr-devel apr-util-devel pcre-devel
wget -c $APACHE_URL/$APACHE_SOFT 
tar -xvf $APACHE_SOFT
cd httpd-$APACHE_VER
./configure --prefix=$APACHE_DIR/ $APACHE_ARG
make
make install 
$APACHE_DIR/bin/apachectl start
ps -ef|grep httpd
netstat -ntpl |grep 80
systemctl stop firewalld.service
system 0
echo "$APACHE_DIR/bin/apachectl start" >>/etc/rc.local 




