# Dapr Self-Hosted Setup
This repo contains a Docker Compose setup for running Dapr in self-hosted mode, providing all the necessary runtime services exactly as created by the `dapr init` CLI command. It offers a quick way to get a complete Dapr runtime environment for local development and testing of distributed applications.

![Dapr Architecture Diagram](./assets/dapr-stack.drawio.svg)


## ⚙️ Prerequisites

- [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/) installed on your machine.

## 🏗️ Architecture

This setup provides the complete Dapr self-hosted runtime environment:

- **dapr_placement** - Dapr placement service for actor placement (port 50005)
- **dapr_scheduler** - Dapr scheduler service for reliable scheduling (port 50006)  

All containers run within a dedicated `dapr-network` bridge network for secure inter-service communication.

## 🚀 Setup & Usage

> The setup in this repo is geared for local development usage and should not be considered for production without adjustments.

### 1. Start the Dapr runtime services:

	```bash
    docker compose -f docker-compose.yml up -d

    # Or if the containers have already been created
    docker compose -f docker-compose.yml start

	```

	This will start all Dapr runtime services using the provided configuration and create the necessary network and volumes for data persistence.

	To bring the compose down, use this command:

	```bash
	docker compose -f docker-compose.yml down -v
	```

	To force a rebuild and deploy of an individual container use this command:  

	```bash
	docker compose -f docker-compose.yml up -d --force-recreate --no-deps --build <service_name>
	```

### 2. Verify Services are Running:
	```bash
	# Check all services status
	docker compose ps
	
	# Check health endpoints
	curl http://localhost:58080/healthz  # Placement service
	curl http://localhost:58081/healthz  # Scheduler service
	```

### 3. Use with Your Dapr Applications:
	- Your Dapr applications will automatically connect to these services when running with `dapr run`
	- The placement service handles actor placement at `localhost:50005`
	- The scheduler service provides reliable scheduling at `localhost:50006`

## 🛠️ Customization

- Modify `docker-compose.yml` to adjust service configurations, ports, or resource limits as needed for your environment.
- Refer to the [Dapr documentation](https://docs.dapr.io/) for advanced configuration options and component setup.

## 📊 Service Endpoints & Ports

### Core Services
- **Placement Service**: `localhost:50005` (gRPC)
  - Health Check: `localhost:58080/healthz`
  - Metrics: `localhost:59090/metrics`
- **Scheduler Service**: `localhost:50006` (gRPC)
  - Health Check: `localhost:58081/healthz` 
  - Metrics: `localhost:59091/metrics`
  - etcd Client: `localhost:52379`

## 🐞 Troubleshooting

- Check container logs for errors:
  ```bash
  docker compose logs
  
  # Or for a specific service
  docker compose logs dapr_placement
  docker compose logs dapr_scheduler
  ```
- Ensure no port conflicts with existing services on your machine.
- Validate that Docker has sufficient resources allocated for all containers.
- Check that volumes have proper permissions for data persistence.

## 🌐 Community & Support

- 🤝 Contributing Guide – see [CONTRIBUTING.md](.github/CONTRIBUTING.md)
- 🤗 Code of Conduct – see [CODE_OF_CONDUCT.md](.github/CODE_OF_CONDUCT.md)
- 🆘 Support Guide – see [SUPPORT.md](.github/SUPPORT.md)
- 🔒 Security Policy – see [SECURITY.md](.github/SECURITY.md)

## 📄 License

This project is licensed under the terms of the repository's main LICENSE file.

---
For more information, see the official documentation for [Dapr](https://docs.dapr.io/) and [Dapr Self-Hosted Mode](https://docs.dapr.io/operations/hosting/self-hosted/).
