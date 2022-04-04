up: #Containers start
	docker-compose up -d

down: #Stop
	docker-compose stop

ps:
	docker ps

connect_ruby:
	docker exec -it 45b5e43befb9 bash

connect_db:
	docker exec -it 21bf0c17fa27 bash