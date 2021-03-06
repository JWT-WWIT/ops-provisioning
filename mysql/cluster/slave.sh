#!/bin/bash
RUNDIR=$(pwd)
systemctl stop mysqld.service
sed -i 's/#read-only/read-only/g' /etc/my.cnf
sed -i 's/#super-read-only/super-read-only/g' /etc/my.cnf
systemctl start mysqld.service
echo ""
echo "Slave hostname is $(hostname)"
echo "Master hostname should be similar"
echo ""
echo -n "Type master hostname: "
read MASTER_HOST
cat cluster/sql/101-slave.sql.tpl | sed -e s/BENDERRODIGUEZ/$MASTER_HOST/g > cluster/sql/101-slave.sql
mysql < cluster/sql/101-slave.sql
systemctl restart mysqld.service
