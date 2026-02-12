# High level status of all containers

echo "============================================================================"
echo "DOCKER INFO STATUS"
echo "============================================================================"

sudo docker info | grep "Containers:" && \
sudo docker info | grep "Running:" && \
sudo docker info | grep "Paused:" && \
sudo docker info | grep "Stopped:"

printf "\n\n============================================================================\n"
echo "DOCKER CONTAINERS ALL"
echo "============================================================================"
sudo docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"


printf "\n\n============================================================================\n"
echo "DOCKER IMAGES ALL"
echo "============================================================================"

# All images on the system
sudo docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}" | { head -1000; sort; }


printf "\n\n============================================================================\n"
echo "DOCKER IMAGES WITH CONTAINERS"
echo "============================================================================"

# All images with containers
sudo docker ps -a --format "table {{.Image}}\t{{.Names}}\t{{.Status}}" | { head -1000; sort; }