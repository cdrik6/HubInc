# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: caguillo <caguillo@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/01/20 21:09:21 by caguillo          #+#    #+#              #
#    Updated: 2025/01/31 02:07:16 by caguillo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SRCS = ./srcs/docker-compose.yml
DC = docker-compose -f

all:
	mkdir -p /home/caguillo/data
	mkdir -p /home/caguillo/data/wordpress
	mkdir -p /home/caguillo/data/mariadb
	docker ps -q | grep . || sudo $(DC) $(SRCS) up --build -d
	
re: fclean all

logs:
	sudo $(DC) $(SRCS) logs
	
stop:
	sudo $(DC) $(SRCS) stop

restart:
	sudo $(DC) $(SRCS) start

down: stop
	sudo $(DC) $(SRCS) down
# stop and delete services

clean: stop 
	sudo $(DC) $(SRCS) down --rmi all
# -v deletes volumes
# stop and delete services, remove containers, images, network (volumes if -v)

fclean: clean
	sudo docker system prune -af --volumes
	sudo rm -rf /home/caguillo/data	
	
# sudo rm -rf /home/caguillo/data/wordpress_data
# sudo rm -rf /home/caguillo/data/mariadb_data	
# -a removes all unused images
# -f bypasses the prompt = force
# to delete volumes: --volumes