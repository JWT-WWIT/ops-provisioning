#!/bin/bash
echo "Master server is: $(hostname)"
mysql < cluster/sql/101-master.sql
systemctl restart mysqld
echo 'SHOW MASTER STATUS;' | mysql
echo BYE
