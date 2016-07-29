#!/bin/bash
echo "Master server is: $(hostname)"
mysql < cluster/sql/101-master.sql
systemctl stop mysqld
echo PLEASE PREPARE SLAVE AND PRESS ENTER WHEN READY
read ENTER
systemctl start mysqld
echo 'SHOW MASTER STATUS;' | mysql
echo BYE
