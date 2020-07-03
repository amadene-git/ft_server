FROM	debian:buster

COPY    /srcs/server-init.sh	/root/
COPY    /srcs/localhost.conf	/root/
COPY    /srcs/localhost.sql		/root/
COPY    /srcs/index.html		/root/
COPY    /srcs/wordpress			/root/wordpress
COPY    /srcs/phpmyadmin		/root/phpmyadmin

RUN	apt-get -y update &&\
    apt-get -y upgrade &&\
    apt-get -y install  nginx\
                        vim\
                        mariadb-server\
                        wget\
                        php\
                        php-cli\
                        php-cgi\
                        php-mbstring\
                        php-fpm\
                        php-mysql\
                        libnss3-tools

WORKDIR		/var/www/localhost/

RUN mv		/root/wordpress								/var/www/localhost/wordpress/
RUN mv		/root/phpmyadmin							/var/www/localhost/phpmyadmin/
RUN mv      /root/index.html							/var/www/localhost/
RUN mv      /root/localhost.conf						/etc/nginx/sites-available/localhost.conf
RUN ln -s   /etc/nginx/sites-available/localhost.conf	/etc/nginx/sites-enabled/
RUN unlink  /etc/nginx/sites-enabled/default
RUN rm      /etc/nginx/sites-available/default
RUN chown -R www-data /var/www/*

WORKDIR /root/mkcert/
RUN wget https://github.com/FiloSottile/mkcert/releases/download/v1.1.2/mkcert-v1.1.2-linux-amd64
RUN chmod +x mkcert-v1.1.2-linux-amd64
RUN ./mkcert-v1.1.2-linux-amd64 -install
RUN ./mkcert-v1.1.2-linux-amd64 localhost

WORKDIR /root/

CMD	bash /root/server-init.sh
