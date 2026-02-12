exit 1 # dont allow this to be run directly


# Show ports for a single container running containers
sudo docker ps --filter="name=otel-collector" --format="table {{.Names}}\t{{.Ports}}"

# High level status of all containers
sudo docker info | grep "Containers:" && \
sudo docker info | grep "Running:" && \
sudo docker info | grep "Paused:" && \
sudo docker info | grep "Stopped:"

# ============================================================================
# Containers
# ============================================================================

# Show all containers
sudo docker ps -a --format "table {{.Names}}\t{{.Image}}"
# Show without ip addresses
sudo docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Ports}}" | sed -r 's/(([0-9]{1,3}\.){3}[0-9]{1,3}:)?([0-9]{2,5}(->?[0-9]{2,5})?(\/(ud|tc)p)?)(, \[?::\]?:\3)?/\3/g'

# Pipeing a speciific container name or ID to a docker command
ctn=<name-or-id> && sudo docker ps -a --filter="name=$ctn" --format "{{.Names}}" | sudo xargs docker <command>


# Remove a specific container by ID or Name
sudo docker rm <CONTAINER_ID_OR_NAME>

## Stream logs for a specific container by ID or Name
sudo  docker logs -f <CONTAINER_ID_OR_NAME>

## Show last 20 lines of logs for a specific container by ID or Name
sudo  docker logs --tail 20 <CONTAINER_ID_OR_NAME>


# ============================================================================
# Images
# ============================================================================

# All images on the system
sudo docker images
sudo docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}" | { head -1000; sort; }

# All images with containers
sudo docker ps
sudo docker ps -a --format "table {{.Image}}\t{{.Names}}\t{{.Status}}" | { head -1000; sort; }

# Prune all unused images that do not have a container associated (running or stopped)
sudo docker image prune -a


# ============================================================================
# Volumes
# ============================================================================
# List all volumes
sudo docker volume ls