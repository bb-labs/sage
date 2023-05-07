.PHONY: up
.PHONY: down
.PHONY: logs
.PHONY: clean


# Dev
up: down 
	docker compose up --build --detach

down:
	docker compose down --remove-orphans

logs:
	docker compose logs -f

clean:
	rm -rf slide-db/data
	docker container rm -f $(docker ps -a -q) 2>/dev/null || true
	for i in ` docker network inspect -f '{{range .Containers}}{{.Name}} {{end}}' slide_default 2>/dev/null || true`; do docker network disconnect -f slide_default $i; done;
	docker system prune -af --volumes
