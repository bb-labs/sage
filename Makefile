.PHONY: up
.PHONY: down
.PHONY: clean

# Dev
up: down 
	docker compose up --build --detach

down:
	docker compose down --remove-orphans

clean:
	rm -rf slide-db/data
	docker container rm -f $(docker ps -a -q) 2>/dev/null || true
	for i in ` docker network inspect -f '{{range .Containers}}{{.Name}} {{end}}' updog_default 2>/dev/null || true`; do docker network disconnect -f slide_default $i; done;
	docker system prune -af --volumes

