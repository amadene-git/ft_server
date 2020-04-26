#!/bin/bash

mkdir	/var/www/localhost

cp	/root/localhost		/etc/nginx/sites-available/localhost
cp	/root/index.html	/var/www/localhost/
cp	/root/info.php		/var/www/localhost/
cp	/root/info-table.php	/var/www/localhost/

service nginx start
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/
unlink /etc/nginx/sites-enabled/default
chown -R www-data /var/www/*


service mysql start
echo "CREATE DATABASE test;" | mysql -u root
echo "CREATE TABLE test.todo_list (     item_id INT AUTO_INCREMENT,     content VARCHAR(255),     PRIMARY KEY(item_id) );" | mysql -u root
echo "INSERT INTO test.todo_list (content) VALUES (\"test 1\");" | mysql -u root
echo "INSERT INTO test.todo_list (content) VALUES (\"test 2\");" | mysql -u root
echo "INSERT INTO test.todo_list (content) VALUES (\"test 3\");" | mysql -u root
echo "CREATE USER 'me'@'localhost' IDENTIFIED BY '1234';" | mysql -u root
echo "GRANT ALL ON test.* TO 'me'@'localhost';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
#GRANT ALL ON example_database.* TO 'example_user'@'localhost' IDENTIFIED BY 'password' WITH GRANT OPTION;
#SELECT * FROM example_database.todo_list;


cd	/var/www/localhost/

echo "CREATE DATABASE wordpress;" | mysql -u root
echo "GRANT ALL ON wordpress.* TO 'me'@'localhost';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
wget http://fr.wordpress.org/latest-fr_FR.tar.gz
tar -xvf latest-fr_FR.tar.gz 
rm latest-fr_FR.tar.gz
cp /root/wp-config.php /var/www/localhost/wordpress


wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -xvf phpMyAdmin-*.tar.gz 
rm phpMyAdmin-4.9.0.1-all-languages.tar.gz
mv phpMyAdmin-4.9.0.1-all-languages/ phpmyadmin

mkdir /root/mkcert/
cd /root/mkcert/
wget https://github.com/FiloSottile/mkcert/releases/download/v1.1.2/mkcert-v1.1.2-linux-amd64
mv mkcert-v1.1.2-linux-amd64 mkcert
chmod +x mkcert
./mkcert -install
./mkcert localhost



service php7.3-fpm start
service nginx restart

bash

