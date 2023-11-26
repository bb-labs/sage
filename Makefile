include .env
export


tidy:
	go mod tidy
	
build:
	envsubst < docker-compose.yml | docker compose -f - build

up: down
	envsubst < docker-compose.yml | docker compose -f - up --build
	
shell:
	docker exec -it $(container) bash

down:
	envsubst < docker-compose.yml | docker compose -f - down --remove-orphans

logs:
	envsubst < docker-compose.yml | docker compose -f - logs --follow $(service)

release:
	gh workflow run 'Sage CI/CD'

status:
	docker container ls

clean: down
	docker system prune -af
	docker volume prune -af


define gen_protos
	protoc -I=protos --swift_out=src/ios/Slide/Protos $1.proto
	pipenv run python src/ios/proto.py $1.pb.swift
	
	protoc -I=protos --go_out=src/protos --go_opt=paths=source_relative $1.proto
endef

proto:
	@$(call gen_protos,"sage")
	@$(call gen_protos,"net")
