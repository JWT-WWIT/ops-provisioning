#!/bin/bash
set -x
RUNDIR=$(pwd)
source includes/globals.sh
systemctl stop mysqld.service
cd /var/lib
tar cvJf mysql.txz mysql
echo "PRESS ENTER TO DELETE MYSQL DIR"
read ENTER
rm -rfv /var/lib/mysql/*
echo "ENTER MASTER SSH PASS"
scp -rp root@$MASTER_HOST:/var/lib/mysql /var/lib
chown -R mysql:mysql /var/lib/mysql
rm  -f /var/lib/mysql/auto.cnf
systemctl start mysqld.service
mysql_upgrade -p$PASS
cd $RUNDIR
cat sql/101-slave.sql.tpl | sed -e s/BENDERRODIGUEZ/$MASTER_HOST/g > sql/101-slave.sql
echo "PRESS ENTER TO START SLAVE"
mysql --force -p$PASS < sql/101-slave.sql
