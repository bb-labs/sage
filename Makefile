export $(yq 'to_entries | map(.key + "=" + .value) | join(" ")' kube/values.yaml)

backtidy:
	cd app; go mod tidy
	
backbuild:
	cd app; envsubst < docker-compose.yml | docker compose -f - build

backup: backdown
	cd app; envsubst < docker-compose.yml | docker compose -f - up --build

backdown:
	cd app; envsubst < docker-compose.yml | docker compose -f - down --remove-orphans

backlogs:
	cd app; envsubst < docker-compose.yml | docker compose -f - logs --follow $(service)

backstatus:
	docker container ls

backclean: backdown
	docker system prune -af
	docker volume prune -af

frontup: frontdown
	cd ios; osascript ios/build.js

frontdown:
	cd ios; osascript ios/kill.js


define gen_protos
	protoc -I=protos --swift_out=ios/Slide/Protos $1.proto
	pipenv run python ios/proto.py $1.pb.swift
	
	protoc -I=protos --go_out=app/protos --go_opt=paths=source_relative $1.proto
endef

proto:
	@$(call gen_protos,"sage")
	@$(call gen_protos,"net")
