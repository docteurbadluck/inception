COMPOSE_FILE = srcs/docker-compose.yml

.DEFAULT_GOAL := up

up:
	docker-compose -f $(COMPOSE_FILE) up --build -d
	@echo "🟢 Containers are up and running."

down:
	docker-compose -f $(COMPOSE_FILE) down
	@echo "🛑 Containers stopped."

clean:
	docker-compose -f $(COMPOSE_FILE) down -v
	@echo "🧹 Containers and volumes removed."

fclean:
	docker-compose -f $(COMPOSE_FILE) down -v --rmi all --remove-orphans
	@echo "🔥 Everything removed (containers, volumes, images)."

