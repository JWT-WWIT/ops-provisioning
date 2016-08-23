# MySQL
**Database and related stuff**

**Usage: Clone and deploy**

We have a lot of things running in MySQL. What we have in this repo?

**/cluster**: Useful scripts for enable in few steps a MySQL based cluster. To enable a cluster you will need to go to the install directory first. 

**/common**: Scripts useful for other scripts.

**/config**: Configuration for present and future MySQL releases following our current tuning and standards.

**/install**: Here there are installation scripts for the CentOS and probably works in RedHat. 


## 1. Installation
As requisite you will have to use RHEL/CentOS/Oracle version 7.x


    install/mysql57-el7.sh

## 2. Configuration

**Password plugin policy**

Just right now we're disabling this, try to use it in the future, reason: Weak app passwords in apps and devs.

Run logged as root

    mysql

Run this sentence

    UNINSTALL PLUGIN VALIDATE_PASSWORD;
    EXIT;

**Setting-up the config files**

For the my.cnf choose the file correspondent to your MySQL version, example

    ## Disable interactive copy
    unalias cp
    
    ## Stop MySQL
    systemctl stop mysqld

    ## If you're using 5.7
    cp config/my57.cnf.template /etc/my.cnf

**Assign server-id**

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

**Change a user password (in mysql cli)**

    SET PASSWORD FOR 'user'@'%' = PASSWORD('mypass');
    FLUSH PRIVILEGES;

**Enable password-less login (Recommended)**

    mysql_config_editor reset
    mysql_config_editor set --user=root --password

**Export one database:**

    mysqldump <database-name> --single-transaction --set-gtid-purged=OFF > /path/database.sql

**Restore one database:**

    mysql < /path/database.sql


**Export all databases (use carefully):**

    mysqldump --all-databases --single-transaction --set-gtid-purged=OFF > /path/mysql-all.sql

**Restore all databases:**

-IMPORTANT IF YOU HAVE SLAVES-: If you're restoring from a previous version of MySQL server you must disable the read-only mode in slave servers (Check your /etc/my.cnf), run mysql_upgrade after the restore operation in all hosts, if you have slaves servers you'll have to turn off the read-only feature temporarily in my.cnf file. Don't forget to re-enable the read-only mode in slaves. Restore a full database in a master node could make reset the slaves in a worst case scenario. In production it's recommended to perform dumps/restores per database.

    mysql < /path/mysql-all.sql



**Reset all mysql data (Dangerous) Lines are commented**
Don't forget backup your files

    # systemctl stop mysqld
    # rm -rvf /var/lib/mysql/*
    # sed -i d /var/log/mysqld.log
    # rm -f /root/.mylogin.cnf

-BEGIN AGAIN: 1. Installation-

