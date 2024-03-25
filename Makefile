# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: asolano- <asolano-@student.42malaga.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/03/08 08:51:14 by asolano-          #+#    #+#              #
#    Updated: 2024/03/21 11:19:52 by asolano-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


inception: build up

copy_env:
	@test -d ./srcs/.env || cp /.env ./srcs/.env

create_volumes:
	@test -d /home/asolano-/data/wordpress || mkdir -p /home/asolano-/data/wordpress
	@test -d /home/asolano-/data/mariadb || mkdir -p /home/asolano-/data/mariadb

build:
	@docker compose -f srcs/docker-compose.yml build

up: create_volumes 
	@docker compose -f srcs/docker-compose.yml up

start:
	@docker compose -f srcs/docker-compose.yml start

down:
	@docker compose -f srcs/docker-compose.yml down

stop:
	@docker compose -f srcs/docker-compose.yml stop

clean_container:
	@docker rm $$(docker ps -qa) 2>/dev/null || true

clean_image:
	@docker rmi -f $$(docker images -qa) 2>/dev/null || true

empty_volume:
	@rm -rf /home/asolano-/data/wordpress/*
	@rm -rf /home/asolano-/data/mariadb/*

clean_volume:
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true

clean_network:
	@docker network rm $$(docker network ls -q) 2>/dev/null || true

clean: down clean_container clean_network

fclean: clean clean_image clean_volume empty_volume

.PHONY: inception create_volumes build up down stop clean_container clean_image empty_volume clean_volume clean_network clean fclean
