.PHONY: front-up
.PHONY: front-down
.PHONY: front-logs
.PHONY: front-clean
.PHONY: back-up
.PHONY: back-down
.PHONY: back-logs
.PHONY: back-clean

# TODO(trumanpurnell) - fix this janky cd shit

back-up: back-down
	cd back; docker compose up --build --detach

back-down:
	cd back; docker compose down --remove-orphans

back-logs:
	cd back; docker compose logs -f

back-clean:
	cd back; rm -rf sage-db/data
	cd back; docker container rm -f $(docker ps -a -q) 2>/dev/null || true
	cd back; for i in ` docker network inspect -f '{{range .Containers}}{{.Name}} {{end}}' sage_default 2>/dev/null || true`; do docker network disconnect -f sage_default $i; done;
	cd back; docker system prune -af --volumes

front-up:
	cd front; osascript ios/build.js
