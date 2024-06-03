include .env
export

drop:
	psql ${DB_ENGINE}://${POSTGRES_USER}:${POSTGRES_PASSWORD}@localhost:${DB_PORT}/${POSTGRES_DB} -c "delete from users where true"

select:
	psql ${DB_ENGINE}://${POSTGRES_USER}:${POSTGRES_PASSWORD}@localhost:${DB_PORT}/${POSTGRES_DB} -c "select * from users"

deps:
	cd ${APP_PATH}; go get github.com/bb-labs/corner; go mod tidy

build:
	envsubst < docker-compose.dev.yml | docker compose -f - build

up: down
	envsubst < docker-compose.dev.yml | docker compose -f - up --build

down:
	envsubst < docker-compose.dev.yml | docker compose -f - down --remove-orphans

shell:
	docker exec -it $(container) bash

logs:
	envsubst < docker-compose.dev.yml | docker compose -f - logs $(service)

clean: down
	docker system prune -af
	docker volume prune -af

proto:
	protoc sage.proto --dart_out=grpc:app/lib/proto

	protoc sage.proto \
		--go_out=service/pb \
		--go_opt=paths=source_relative \
		--go-grpc_out=service/pb \
		--go-grpc_opt=paths=source_relative
	
