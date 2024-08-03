deploy:
	docker-compose --context cb up --build -d

deploy-debug:
	docker-compose --context cb up --build

deploy-test:
	docker-compose --context cb-test up cb adminer --build
