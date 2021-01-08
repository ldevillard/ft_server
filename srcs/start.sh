# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ldevilla <ldevilla@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/07 12:34:12 by ldevilla          #+#    #+#              #
#    Updated: 2021/01/08 11:32:18 by ldevilla         ###   ########lyon.fr    #
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

service nginx start
service mysql start
service php7.3-fpm start
#sleep infinity
#bash
tail -f /var/log/nginx/access.log -f /var/log/nginx/error.log