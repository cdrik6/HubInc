# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: caguillo <caguillo@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/01/20 21:09:21 by caguillo          #+#    #+#              #
#    Updated: 2025/02/25 01:16:17 by caguillo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SRCS_PATH = ./srcs
YML = $(SRCS_PATH)/docker-compose.yml
DC := $(shell \
    if command -v docker compose > /dev/null 2>&1; then \
        echo "docker compose -f"; \
    else \
        echo "docker-compose -f"; \
    fi)

	
all:
	check_env
	volumes
	docker ps -q | grep . || $(DC) $(YML) up --build -d

all-d:
	mkdir -p /home/caguillo/data
	mkdir -p /home/caguillo/data/mariadb
	mkdir -p /home/caguillo/data/wordpress
	docker ps -q | grep . || $(DC) $(YML) up --build
	
re: fclean all

logs:
	$(DC) $(YML) logs -f
	
stop:
	$(DC) $(YML) stop

restart:
	$(DC) $(YML) start

down: stop
	$(DC) $(YML) down
# stop and delete services

clean: stop 
	$(DC) $(YML) down --rmi all -v --remove-orphans
# -v deletes volumes
# stop and delete services, remove containers, images, network (volumes if -v)

fclean: clean
	docker system prune -af --volumes
	sudo rm -rf /home/caguillo/data

check_env:
	if [ ! -f $(SRCS_PATH)/.env ]; then \
		echo ".env file is missing!"; \
		exit 1; \
	fi

volumes:	
	mkdir -p /home/caguillo/data
	mkdir -p /home/caguillo/data/mariadb
	mkdir -p /home/caguillo/data/wordpress		

.PHONY: all all-d up down re logs stop restart clean fclean
	
# sudo rm -rf /home/caguillo/data/wordpress_data
# sudo rm -rf /home/caguillo/data/mariadb_data	
# -a removes all unused images
# -f bypasses the prompt = force
# to delete volumes: --volumes

# sudo docker-compose run --rm mariadb sh -c "rm -f /var/run/mysqld/mysqld.pid"