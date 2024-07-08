include .env
export


deps:
	cd ${APP_PATH}; go get github.com/bb-labs/corner; go mod tidy

seed:
	go run ${APP_PATH}/seed/seed.go

build:
	envsubst < docker-compose.dev.yml | docker compose -f - build

up: down
	$$(aws configure export-credentials --format env); \
	envsubst < docker-compose.dev.yml | docker compose -f - up --build

down:
	envsubst < docker-compose.dev.yml | docker compose -f - down --remove-orphans

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
	
