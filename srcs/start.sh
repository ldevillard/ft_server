# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ldevilla <ldevilla@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/07 12:34:12 by ldevilla          #+#    #+#              #
#    Updated: 2021/01/08 13:10:26 by ldevilla         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

#NGINX
cp /srcs/default /etc/nginx/sites-available/default

#PHP MYADMIN
cd var/www/html
mkdir phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -zxvf phpMyAdmin-4.9.0.1-all-languages.tar.gz
cp -r phpMyAdmin-4.9.0.1-all-languages/* phpmyadmin
rm -rf phpMyAdmin-4.9.0.1-all-languages phpMyAdmin-4.9.0.1-all-languages.tar.gz
cp /srcs/config.inc.php ./phpmyadmin

#MYSQL
service mysql start
echo "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;" | mysql -u root
echo "GRANT ALL ON wordpress.* TO '${USER}'@'localhost' IDENTIFIED BY '${PASSWORD}';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

#WORDPRESS
wget https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz && rm -rf latest.tar.gz
cp /srcs/wp-config.php /var/www/html
sed 's/username_here/'${USER}'/g' wp-config.php
sed 's/password_here/'${PASSWORD}'/g' wp-config.php

service nginx start
service php7.3-fpm start
#sleep infinity
#bash
tail -f /var/log/nginx/access.log -f /var/log/nginx/error.log