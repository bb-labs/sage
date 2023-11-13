include .env.dev
export

env = dev

tidy:
	cd app; go mod tidy

dump:
	mongoexport --uri='mongodb://${DB_USERNAME}:${DB_PASSWORD}@localhost:${DB_SERVICE_PORT}/${DB_NAME}?authsource=admin' --collection=${DB_NAME} --pretty
	
build:
	envsubst < docker-compose.yml | docker compose -f - build

up: down
	envsubst < docker-compose.yml | docker compose -f - up --build

down:
	envsubst < docker-compose.yml | docker compose -f - down --remove-orphans

logs:
	envsubst < docker-compose.yml | docker compose -f - logs --follow $(service)

shell:
	docker exec -it $(container) bash

status:
	docker container ls

clean: down
	docker system prune -af
	docker volume prune -af


