include .env
export

db:
	mongoexport --uri='mongodb://${MONGO_INITDB_ROOT_USERNAME}:${MONGO_INITDB_ROOT_PASSWORD}@localhost:${DB_PORT}/${MONGO_INITDB_DATABASE}?authsource=admin' --collection=${DB_USERS_COLLECTION} --pretty
	mongoexport --uri='mongodb://${MONGO_INITDB_ROOT_USERNAME}:${MONGO_INITDB_ROOT_PASSWORD}@localhost:${DB_PORT}/${MONGO_INITDB_DATABASE}?authsource=admin' --collection=${DB_SIGNALING_COLLECTION} --pretty
	
build:
	envsubst < docker-compose.yml | docker compose -f - build

up: down
	envsubst < docker-compose.yml | docker compose -f - up --build
	
shell:
	docker exec -it $(container) bash

down:
	envsubst < docker-compose.yml | docker compose -f - down --remove-orphans

logs:
	envsubst < docker-compose.yml | docker compose -f - logs $(service)

release:
	gh workflow run 'Sage CI/CD'

status:
	kubectl --kubeconfig kube/config get po -o wide
	kubectl --kubeconfig kube/config get svc
	kubectl --kubeconfig kube/config get endpoints -A 
	kubectl --kubeconfig kube/config get ingress -A
	kubectl --kubeconfig kube/config get issuer -A
	kubectl --kubeconfig kube/config get certificate -A

clean: down
	docker system prune -af
	docker volume prune -af

config:
	cp .env ios/Slide/Config/Config.xcconfig
	pipenv run python ios/config.py

define gen_protos
	protoc -I=protos --swift_out=ios/Slide/Protos $1.proto
	pipenv run python ios/proto.py $1.pb.swift
	
	protoc -I=protos --go_out=app/protos --go_opt=paths=source_relative $1.proto
endef

proto:
	@$(call gen_protos,"sage")
	@$(call gen_protos,"net")
