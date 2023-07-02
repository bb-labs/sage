

ifneq (,$(wildcard ./.env.dev))
    include .env.dev
    export
endif

dev-dump:
	mongoexport --uri='mongodb://root:password@localhost:4001/sage_wss?authsource=admin' --collection=webRtc --pretty
	@echo "\n\n\n\n\n"
	mongoexport --uri='mongodb://root:password@localhost:3001/sage_app?authsource=admin' --collection=users --pretty
	
dev-up: dev-down
	set -a; . ./.env.dev; docker compose up --build --detach

dev-down:
	docker compose down --remove-orphans

dev-logs:
	docker compose logs -f $(service)

dev-shell:
	docker exec -it $(container) bash

dev-status:
	docker container ls

dev-clean:
	rm -rf app/db/data
	rm -rf signaling/db/data
	rm -rf auth/db/data
	docker container rm -f $(docker ps -a -q) 2>/dev/null || true
	for i in ` docker network inspect -f '{{range .Containers}}{{.Name}} {{end}}' sage_default 2>/dev/null || true`; do docker network disconnect -f sage_default $i; done;
	docker system prune -af --volumes

stage-push:
	sh docker.sh signaling

stage-apply:
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