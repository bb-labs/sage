include .env
export

drop:
	psql ${DB_ENGINE}://${POSTGRES_USER}:${POSTGRES_PASSWORD}@localhost:${DB_PORT}/${POSTGRES_DB} -c "delete from users where true"

select:
	psql ${DB_ENGINE}://${POSTGRES_USER}:${POSTGRES_PASSWORD}@localhost:${DB_PORT}/${POSTGRES_DB} -c "select * from users"

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
	protoc sage.proto -I=protos \
		--swift_out=ios/Slide/Protos \
		--grpc-swift_out=ios/Slide/Protos
	
	awyes --no-verbose save_ios_protos

	protoc sage.proto -I=protos \
		--go_out=app/pb \
		--go_opt=paths=source_relative \
		--go-grpc_out=app/pb \
		--go-grpc_opt=paths=source_relative
	
	protoc sage.proto -I=protos \
		--go_out=wss/pb \
		--go_opt=paths=source_relative
