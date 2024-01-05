include .env
export

db-dump:
	mongoexport --uri='mongodb://${MONGO_INITDB_ROOT_USERNAME}:${MONGO_INITDB_ROOT_PASSWORD}@localhost:${DB_PORT}/${MONGO_INITDB_DATABASE}?authsource=admin' --collection=${DB_USERS_COLLECTION} --pretty

db-wipe:
	mongo -u ${MONGO_INITDB_ROOT_USERNAME} -p '${MONGO_INITDB_ROOT_PASSWORD}' --authenticationDatabase admin --eval "db.getSiblingDB('${MONGO_INITDB_DATABASE}').dropDatabase()"

db-seed: db-wipe
	mongoimport --uri='mongodb://${MONGO_INITDB_ROOT_USERNAME}:${MONGO_INITDB_ROOT_PASSWORD}@localhost:${DB_PORT}/${MONGO_INITDB_DATABASE}?authsource=admin' --collection=${DB_USERS_COLLECTION} --file=db/seed.users.json --jsonArray

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

kube:
	kubectl --kubeconfig kube/config get po -o wide
	kubectl --kubeconfig kube/config get svc
	kubectl --kubeconfig kube/config get endpoints -A 
	kubectl --kubeconfig kube/config get ingress -A
	kubectl --kubeconfig kube/config get issuer -A
	kubectl --kubeconfig kube/config get certificate -A

clean: down
	docker system prune -af
	docker volume prune -af

proto:
	protoc sage.proto -I=protos \
		--swift_out=ios/Slide/Protos \
		--grpc-swift_out=ios/Slide/Protos
	
	pipenv run python ios/proto.py sage.pb.swift
	pipenv run python ios/proto.py sage.grpc.swift

	protoc sage.proto -I=protos \
		--go_out=app/pb \
		--go_opt=paths=source_relative \
		--go-grpc_out=app/pb \
		--go-grpc_opt=paths=source_relative
