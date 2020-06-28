#!/bin/bash
#2020.6.19 16:00:00
#auto install jdk
#by author lh
###################
J_VER="jdk-8u251-linux-i586.tar.gz"
J_DIR="jdk1.8.0_251"



yum install -y glibc.i686

tar -zxvf $J_VER
cp $J_DIR /usr/local/
echo "
export JAVA_HOME=/usr/local/$J_DIR
export JRE_HOME=/usr/local/${J_DIR}/jre
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib
export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH">>/etc/profile

source /etc/profile

java -version


