up: #Containers start
	docker-compose up -d

down: #Stop
	docker-compose stop

ps:
	docker ps

connect_ruby:
	docker exec -it ca8d686c8569 bash

connect_db:
	docker exec -it 97fc5938319a bash