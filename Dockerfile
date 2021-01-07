# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ldevilla <ldevilla@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/28 12:22:11 by ldevilla          #+#    #+#              #
#    Updated: 2021/01/07 13:02:45 by ldevilla         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update
RUN apt-get -y install nginx
RUN apt-get -y install php 
RUN apt-get -y install php-fpm

COPY srcs/* /srcs

CMD sh srcs/start.sh
