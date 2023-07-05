

include .env.dev
export

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

stage-push:
	sh docker.sh signaling

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