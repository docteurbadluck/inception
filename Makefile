ENV_FILE = srcs/.env
COMPOSE_FILE = srcs/docker-compose.yml
DOCKER_COMPOSE = env $(shell cat $(ENV_FILE) | xargs) docker-compose -f $(COMPOSE_FILE)

.DEFAULT_GOAL := up

up:
	@$(DOCKER_COMPOSE) up --build -d
	@echo "🟢 Containers are up and running."

down:
	@$(DOCKER_COMPOSE) down
	@echo "🛑 Containers stopped."

clean:
	@$(DOCKER_COMPOSE) down -v
	@echo "🧹 Containers and volumes removed."

fclean:
	@$(DOCKER_COMPOSE) down -v --rmi all --remove-orphans
	@echo "🔥 Everything removed (containers, volumes, images)."

re: fclean up
