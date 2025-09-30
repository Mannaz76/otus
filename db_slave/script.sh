#!/bin/bash

#обновляем репо и уcтанавливаем mysql
apt update && apt install mysql-server -y

#запускаем
systemctl start mysql

cp ./otus/db_slave/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

systemctl restart mysql

mysql -u root << EOF

CHANGE MASTER TO MASTER_HOST='192.168.11.23', MASTER_USER='repl', MASTER_PASSWORD='oTUSlave#2020', MASTER_LOG_FILE='binlog.000005', MASTER_LOG_POS=688, GET_MASTER_PUBLIC_KEY = 1;
START SLAVE;
EOF


