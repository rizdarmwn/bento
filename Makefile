build:
	go build -v -o bin/ ./...

run:
	go build -v -o bin/bento ./... && ./bin/bento

compose-up:
	docker-compose --project-name bento -f docker-compose.yaml up -d

compose-down:
	docker-compose --project-name bento -f docker-compose.yaml down

compose-stop:
	docker-compose --project-name bento -f docker-compose.yaml stop

compose-start:
	docker-compose --project-name bento -f docker-compose.yaml start -d

compose-build:
	docker-compose --project-name bento -f docker-compose.yaml build
