SET GLOBAL master_info_repository = 'TABLE';
SET GLOBAL relay_log_info_repository = 'TABLE';
CHANGE MASTER TO
stagejwtt01='stagejwtt01',
MASTER_USER='repl',
MASTER_PASSWORD='slavepass',
MASTER_AUTO_POSITION=1
FOR CHANNEL 'stagejwtt01';
START SLAVE;
SHOW SLAVE STATUS \G;
