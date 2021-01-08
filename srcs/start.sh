# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ldevilla <ldevilla@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/07 12:34:12 by ldevilla          #+#    #+#              #
#    Updated: 2021/01/08 15:10:48 by ldevilla         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

#NGINX
cp /srcs/default /etc/nginx/sites-available/default #AUTO INDEX ON
#cp /srcs/default_indexoff /etc/nginx/sites-available/default #AUTO INDEX OFF

#MYSQL
service mysql start
mysql -u root -e "CREATE USER '${USER}'@'localhost' IDENTIFIED BY '${PASSWORD}'; 
GRANT ALL PRIVILEGES ON * . * TO '${USER}'@'localhost' WITH GRANT OPTION; 
FLUSH PRIVILEGES;
CREATE DATABASE wordpress;"

#PHP MYADMIN
cd var/www/html
mkdir phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -zxvf phpMyAdmin-4.9.0.1-all-languages.tar.gz > /dev/null
cp -r phpMyAdmin-4.9.0.1-all-languages/* phpmyadmin
rm -rf phpMyAdmin-4.9.0.1-all-languages phpMyAdmin-4.9.0.1-all-languages.tar.gz
cp /srcs/config.inc.php ./phpmyadmin

#WORDPRESS
wget https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz > /dev/null
rm -rf latest.tar.gz
cp /srcs/wp-config.php /var/www/html/wordpress
cd /var/www/html/wordpress
sed -i 's/username_here/'${USER}'/g' wp-config.php
sed -i 's/password_here/'${PASSWORD}'/g' wp-config.php

#SSL
openssl req -x509 -nodes -days 2048 -subj "/C=FR/ST=France/L=Lyon/O=42Lyon/OU=logan/CN=localhost" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;

service nginx start
service mysql restart
service php7.3-fpm start
#sleep infinity
bash
#tail -f /var/log/nginx/access.log -f /var/log/nginx/error.log