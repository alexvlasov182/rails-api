up: #Containers start
	docker-compose up -d

down: #Stop
	docker-compose stop

ps:
	docker ps

connect_ruby:
	docker exec -it d518ea16e09c bash

connect_db:
	docker exec -it b987cac206cd bash