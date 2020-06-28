#!/bin/bash
#2020.5.12 10:10:10
#auto isntall vsftpd 
#by author lh
F_YUM="yum install -y"
F_DIR="/etc/vsftpd"
F_DB="vsftpd_login"
F_VIR="$1"




$F_YUM vsftpd*
rpm -qa |grep vsftpd
systemctl restart vsftpd.service


$F_YUM  pam* libdb-utils libdb* --skip-broken

touch $F_DIR/ftpusers.txt
cat>>$F_DIR/ftpusers.txt<<EOF
${F_VIR}
123456
EOF

db_load -T -t hash -f $F_DIR/ftpusers.txt $F_DIR/${F_DB}.db

chmod 755 $F_DIR/${F_DB}.db

echo "
auth required pam_userdb.so db=$F_DIR/${F_DB}
account required pam_userdb.so db=$F_DIR/${F_DB}">/etc/pam.d/vsftpd

useradd -s /sbin/nologin ftpuser

echo "
pam_service_name=vsftpd
guest_enable=YES
guest_username=ftpuser
user_config_dir=/etc/vsftpd/vsftpd_user_conf
virtual_use_local_privs=YES
">>$F_DIR/vsftpd.conf

mkdir -p /etc/${F_USR}/vsftpd_user_conf
chown -R ftpuser:ftpuser /home/ftpuser
systemctl stop firewalld.service
























