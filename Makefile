$(foreach var,$(shell yq -o=shell kube/values.yaml),$(eval export $(var)))

tidy:
	go mod tidy
	
build:
	envsubst < docker-compose.yml | docker compose -f - build

up: down
	envsubst < docker-compose.yml | docker compose -f - up --build --detach

run: build
	docker run -it --rm $(shell yq 'to_entries | map("-e " + .key + "=" + .value) | join(" ")' kube/values.yaml) $(image)
	
shell:
	docker exec -it $(container) bash

down:
	envsubst < docker-compose.yml | docker compose -f - down --remove-orphans

logs:
	envsubst < docker-compose.yml | docker compose -f - logs --follow $(service)

status:
	docker container ls

clean: backdown
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
