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
	envsubst < docker-compose.yml | docker compose -f - logs $(service)

release:
	gh workflow run 'Sage CI/CD'

status:
	kubectl --kubeconfig kube/config get po -o wide
	kubectl --kubeconfig kube/config get svc
	kubectl --kubeconfig kube/config get endpoints -A 

clean: down
	docker system prune -af
	docker volume prune -af


define gen_protos
	protoc -I=protos --swift_out=ios/Slide/Protos $1.proto
	pipenv run python ios/proto.py $1.pb.swift
	
	protoc -I=protos --go_out=go/protos --go_opt=paths=source_relative $1.proto
endef

proto:
	@$(call gen_protos,"sage")
	@$(call gen_protos,"net")
