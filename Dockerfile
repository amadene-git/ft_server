FROM	debian:buster

COPY	/srcs/server-init.sh 	/root/

COPY	/srcs/localhost		/root/

COPY	/srcs/index.html	/root/

COPY	/srcs/info.php		/root/

COPY	/srcs/info-table.php	/root/

COPY	/srcs/wp-config.php	/root/


RUN	apt-get -y update && apt-get -y install nginx vim mariadb-server wget php  php-cli  php-cgi  php-mbstring  php-fpm  php-mysql  nginx  libnss3-tools



CMD	bash /root/server-init.sh

#CMD 	bash
