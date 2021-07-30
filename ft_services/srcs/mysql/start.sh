#!/bin/sh

#Установка mysql под пользователя root
mariadb-install-db --user=root

#Запуск mysq
mysqld --user=root & sleep 5

mysql --user=root --execute="CREATE DATABASE wordpress;"

#Импортируйте ранее созданную резервную копию базы данных на сервер
mysql --user=root wordpress < wordpress.sql

mysql --user=root --execute="CREATE USER 'root'@'%' IDENTIFIED BY 'pass'; GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION; USE wordpress; FLUSH PRIVILEGES;"

/usr/bin/supervisord -c /etc/supervisord.conf