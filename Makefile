.PHONY: up
.PHONY: down
.PHONY: logs
.PHONY: clean


# Dev
up: down 
	cd back; make up
	cd front; make up

down:
	cd back; make down

logs:
	cd back; make logs

clean:
	cd back; make clean
