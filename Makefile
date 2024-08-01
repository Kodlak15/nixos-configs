deploy:
	docker-compose --context cb up --build -d

deploy-debug:
	docker-compose --context cb up --build
