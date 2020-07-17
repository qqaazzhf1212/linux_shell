#!/bin/bash
#2020.6.28 9:30:00
#auto change network ip
#by author lh
##################
IP_DIR="/etc/sysconfig/network-scripts"
IP_CFG="ifcfg-ens33"
IP_ADDR="192.168.106.129"

cp $IP_DIR/$IP_CFG  $IP_DIR/$IP_CFG-cp
ls $IP_DIR
grep "dhcp" $IP_DIR/$IP_CFG

if [ $? == 0 ];then
cat>${IP_DIR}/${IP_CFG} <<EOF
TYPE="Ethernet"
PROXY_METHOD="none"
BROWSER_ONLY="no"
BOOTPROTO="static"
DEFROUTE="yes"
IPV4_FAILURE_FATAL="no"
IPV6INIT="yes"
IPV6_AUTOCONF="yes"
IPV6_DEFROUTE="yes"
IPV6_FAILURE_FATAL="no"
IPV6_ADDR_GEN_MODE="stable-privacy"
NAME="ens33"
UUID="c93b94ce-9c04-42cd-8ce3-7e4f7e2db7b4"
DEVICE="ens33"
ONBOOT="yes"
IPADDR=${IP_ADDR}
NETMASK=255.255.255.0
GATEWAY=192.168.0.1
DNS=202.103.24.68
EOF
fi

cat $IP_DIR/$IP_CFG

ping -c1 192.168.106.129>>/~/pi.txt
if [ $? -ne 0 ];then
	service network restart
else
	echo -e "\033[32m-----------------------\033[0m"
	echo -e "\033[32m The 192.188 IP Address Already use" 
	exit 1
fi
