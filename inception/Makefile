IMAGE = nginx mariadb wordpress
VOLUME = /home/jaehjoo/data/mariadb /home/jaehjoo/data/wordpress
NETWORK = intra
SRCS = ./srcs

all:
	@make up
up:
	@mkdir -p $(VOLUME)
	@docker-compose -f $(SRCS)/docker-compose.yml up -d --build
down:
	@docker-compose -f $(SRCS)/docker-compose.yml down
clean:
	@if [ -n "$$(docker ps -qa)" ]; then \
		docker stop $$(docker ps -qa); \
		docker rm $$(docker ps -qa); \
	fi
	@if [ -n "$$(docker images -qa)" ]; then \
		docker rmi $$(docker images -qa); \
	fi
	@if [ -n "$$(docker network ls | grep $(NETWORK))" ]; then \
		docker network rm $$(docker network ls | grep $(NETWORK) | awk 'NF=1 {print $$0}'); \
	fi
	@if [ -n "$$(docker volume ls -q)" ]; then \
		docker volume rm $$(docker volume ls -q); \
	fi
fclean:
	@rm -rf $(VOLUME)
	@make clean
re:
	@make fclean
	@make all