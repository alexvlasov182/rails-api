up: #Containers start
	docker-compose up -d

down: #Stop
	docker-compose stop

ps:
	docker ps

connect_ruby:
	docker exec -it 7755907ed1ef bash

connect_db:
	docker exec -it e5eccab1f541 bash