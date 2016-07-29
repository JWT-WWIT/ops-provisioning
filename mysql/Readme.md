# MySQL
**Database and related stuff**

**Usage: Clone and deploy**

We have a lot of things running in MySQL. What we have in this repo?

**/cluster**: Usefull scripts for enable in few steps a MySQL based cluster. To enable a cluster you will need to go to the install directory first. 

**/common**: Scripts usefull for other scripts.

**/config**: Configuration for present and future MySQL releases following our current tuning and  standards.

**/install**: Here there are instalation scripts for the CentOS and probably works in RedHat. 


## 1. Installation
As pre-requisite you will have to use RHEL/CentOS/Oracle version 7.x

**For MySQL 5.6**

    install/mysql56-single-centos7.sh

**For MySQL 5.7**

    install/mysql56-single-centos7.sh
## 2. Configuration

**Password plugin policy**

Just right now we're disabling this, try to use it in the future, reason: Weak app passwords in apps and devs.

Run logged as root

    mysql

Run this sentence

    UNINSTALL PLUGIN VALIDATE_PASSWORD;

**Setting-up the config files**

For th my.cnf choose the file correspondant to yout MySQL version, example

    unalias cp
    systemctl stop mysqld


    ## If you're using 5.6
    cp config/my56.cnf.template /etc/my.cnf

    ## If you're using 5.7
    cp config/my57.cnf.template /etc/my.cnf

**Assingn server-id**

    common/set-server-id.sh

**Start MySQL process**

    systemctl start mysqld

## Optional A: Enable a master/slave cluster

Instructions for a replicated master-slave solution (two nodes).

**Master node**

Run this script:

    cluster/master.sh

**Slave node**

Run this script:

    cluster/slave.sh

## Useful commands:

Export all databases:

    mysqldump --all-databases --single-transaction --set-gtid-purged=OFF > /tmp/mysql-all.sql

Restore all databases:

    mysql < /tmp/mysql-all.sql
