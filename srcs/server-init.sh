#!/bin/bash

service mysql start
read -p "MySQL User :" user_name
read -p 'Password :' -s mdp
echo "Création de la db..."

echo "CREATE USER '$user_name'@'localhost' IDENTIFIED BY '$mdp';" | mysql -u root
echo "CREATE DATABASE wordpress;" | mysql -u root
echo "GRANT ALL ON wordpress.* TO '$user_name'@'localhost';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
mysql wordpress -u root < /root/localhost.sql

service php7.3-fpm start
service nginx start

bash

