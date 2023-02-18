.PHONY: dev-up
.PHONY: dev-down
.PHONY: dev-clean

# Dev
dev-up: dev-down 
	docker compose up --build --detach

dev-down:
	docker compose down --remove-orphans

dev-clean:
	rm -rf slide-db/data
	docker container rm -f $(docker ps -a -q) 2>/dev/null || true
	for i in ` docker network inspect -f '{{range .Containers}}{{.Name}} {{end}}' updog_default 2>/dev/null || true`; do docker network disconnect -f slide_default $i; done;
	docker system prune -af --volumes


	