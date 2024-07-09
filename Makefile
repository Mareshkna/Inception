LOGIN = yasabri

all :
	sudo mkdir -p ~/data/wordpress
	sudo mkdir -p ~/data/mariadb
	@ docker compose -f srcs/docker-compose.yml up --build

server_name :
	@ echo "127.0.0.1 ${LOGIN}.42.fr" >> /etc/hosts
	
stop :
	@ docker compose -f srcs/docker-compose.yml down

fclean : stop
	@ docker system prune --volumes -f
	sudo rm -rf ~/data/wordpress
	sudo rm -rf ~/data/mariadb

re : stop all

RE : fclean all

.PHONY: all server_name stop fclean re RE
