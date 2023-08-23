include .env.dev
include .env.secret
export


up: down
	osascript ios/build.js

down:
	osascript ios/kill.js



dev-dump:
	mongoexport --uri='mongodb://${DB_USERNAME}:${DB_PASSWORD}@localhost:${SIGNALING_DB_PORT}/${SIGNALING_DB_NAME}?authsource=admin' --collection=${SIGNALING_DB_TABLE_NAME} --pretty
	@echo "\n\n\n\n\n"
	mongoexport --uri='mongodb://${DB_USERNAME}:${DB_PASSWORD}@localhost:${APP_DB_PORT}/${APP_DB_NAME}?authsource=admin' --collection=${APP_DB_TABLE_NAME} --pretty
	
dev-up: dev-down
	envsubst < docker-compose.yml | docker compose -f - up --build --detach

dev-down:
	envsubst < docker-compose.yml | docker compose -f - down --remove-orphans

dev-logs:
	envsubst < docker-compose.yml | docker compose -f - logs --follow $(service)

dev-shell:
	docker exec -it $(container) bash

dev-status:
	docker container ls

dev-clean: dev-down
	docker system prune -af
	docker volume prune -af

stage-env: 
	pipenv run python kube.py config-map .env.dev > app/db/config.yml
	pipenv run python kube.py secret .env.secret > app/db/secret.yml
	pipenv run python kube.py config-map .env.dev > auth/db/config.yml
	pipenv run python kube.py secret .env.secret > auth/db/secret.yml
	pipenv run python kube.py config-map .env.dev > signaling/db/config.yml
	pipenv run python kube.py secret .env.secret > signaling/db/secret.yml

stage-push:
	sh docker.sh signaling/db
	sh docker.sh app/db
	sh docker.sh auth/db

stage-apply: stage-push
	envsubst < stunner/deployment.yml | kubectl apply -f -
	envsubst < signaling/deployment.yml | kubectl apply -f -

stage-up:
	minikube start 

	kubectl create namespace stunner
	kubectl create namespace stunner-system
	kubectl create namespace signaling

	helm install stunner-gateway-operator stunner/stunner-gateway-operator --namespace=stunner-system
	helm install stunner stunner/stunner --namespace=stunner

stage-down: 
	minikube delete

	kubectl delete namespace stunner
	kubectl delete namespace stunner-system
	kubectl delete namespace signaling

define gen_protos
	protoc -I=protos --swift_out=front/ios/Slide/Protos $1.proto
	pipenv run python front/ios/proto.py $1.pb.swift
	
	protoc -I=protos --go_out=back/app/protos --go_opt=paths=source_relative $1.proto
	protoc -I=protos --go_out=back/auth/protos --go_opt=paths=source_relative $1.proto
	protoc -I=protos --go_out=back/signaling/protos --go_opt=paths=source_relative $1.proto
endef

proto:
	@$(call gen_protos,"sage")
	@$(call gen_protos,"auth")
	@$(call gen_protos,"presign")
	@$(call gen_protos,"rtc")
