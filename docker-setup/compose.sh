# bring up a docker compose file in detached mode
sudo docker compose -f docker-compose.yml up -d

# bring down the docker compose file and remove associated volumes
sudo docker compose -p kafka-stack -f docker-compose.yml down -v

# rebuild a specific service in the docker compose file
sudo docker compose -f docker-compose.yml up -d --force-recreate --no-deps --build <service_name>

# list the running services in the docker compose file
sudo docker compose ps