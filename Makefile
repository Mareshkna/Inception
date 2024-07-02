NAME = inception

all : 
	@ docker compose -f srcs/docker-compose.yml up --build

prune : clean
	@ docker system prune -f

server_name :
	@ echo "127.0.0.1 raccoman.42.fr" >> /etc/hosts
	
stop :
	@ docker compose -f srcs/docker-compose.yml down

clean :
	@docker stop $$(docker ps -qa);\
	docker rm $$(docker ps -qa);\
	docker rmi -f $$(docker images -qa);\
	# docker volume rm $$(docker volume ls -q);
	sudo rm -rf ~/data/wordpress
	# sudo rm -rf ~/data/mariadb

re : prune all

.PHONY: all prune server_name stop clean re
