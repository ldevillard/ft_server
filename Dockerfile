# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ldevilla <ldevilla@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/28 12:22:11 by ldevilla          #+#    #+#              #
#    Updated: 2021/01/08 14:22:56 by ldevilla         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update
RUN apt-get -y install nginx
RUN apt-get -y install php 
RUN apt-get -y install php-fpm
RUN apt-get -y install mariadb-server
RUN apt-get -y install php-json php-mbstring
RUN apt-get -y install wget
RUN apt-get -y install php-mysqlnd

COPY srcs/* srcs/

ENV USER='test'
ENV PASSWORD='yeah'

EXPOSE 80 443

CMD sh srcs/start.sh
