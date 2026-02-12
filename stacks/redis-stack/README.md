# Redis Stack
This repo contains a Docker Compose setup for running Redis locally with RedisInsight for development and testing. It provides a simple, lightweight Redis environment with a web-based management UI.

![Redis Architecture Diagram](./assets/redis-stack.drawio.svg)

## ⚙️ Prerequisites

- [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/) installed on your machine.

## 🏗️ Architecture

This setup provides a local Redis development environment:

- **redis** - Redis server with AOF persistence enabled (port 6379)
- **redis-insight** - RedisInsight web UI for Redis management and monitoring (port 5540)

All containers run within a dedicated `redis-network` bridge network for secure inter-service communication. Data is persisted using Docker volumes for both Redis data and RedisInsight configuration.

## 🚀 Setup & Usage

> The setup in this repo is geared for local development usage and should not be considered for production without adjustments.

### 1. Start the Redis services:

```bash
docker compose up -d

# Or if the containers have already been created
docker compose start
```

This will start Redis and RedisInsight using the provided configuration and create the necessary network and volumes for data persistence.

To bring the compose down, use this command:

```bash
docker compose down -v
```

To force a rebuild and deploy of an individual container use this command:  

```bash
docker compose up -d --force-recreate --no-deps --build <service_name>
```

### 2. Verify Services are Running:
```bash
# Check all services status
docker compose ps

# Test Redis connection
docker exec redis redis-cli ping

# Or use redis-cli directly
redis-cli -h localhost -p 6379 ping
```


## 📊 Service Endpoints & Ports

- **Redis Server**: `localhost:6379` (TCP)
  - Protocol: Redis Protocol (RESP)
  - Persistence: AOF (Append-Only File) enabled
- **RedisInsight**: `localhost:5540` (HTTP)
  - Web UI for Redis management and monitoring

## 💾 Data Persistence

- **Redis Data**: Stored in `vol_redis` Docker volume
  - AOF persistence enabled with `--appendonly yes`
  - Data survives container restarts
- **RedisInsight Data**: Stored in `vol_redis_insight` Docker volume
  - Preserves database connections and preferences

## 🐞 Troubleshooting

- Check container logs for errors:
  ```bash
  docker compose logs
  
  # Or for a specific service
  docker compose logs redis
  docker compose logs redis-insight
  ```
- Ensure no port conflicts with existing services on your machine (especially port 6379 for Redis).
- Validate that Docker has sufficient resources allocated for all containers.
- Check that volumes have proper permissions for data persistence.
- If RedisInsight cannot connect to Redis:
  - Verify both containers are on the same network: `docker network inspect redis-stack_redis-network`
  - Check Redis health: `docker exec redis redis-cli ping`

## 🌐 Community & Support

- 🤝 Contributing Guide – see [CONTRIBUTING.md](.github/CONTRIBUTING.md)
- 🤗 Code of Conduct – see [CODE_OF_CONDUCT.md](.github/CODE_OF_CONDUCT.md)
- 🆘 Support Guide – see [SUPPORT.md](.github/SUPPORT.md)
- 🔒 Security Policy – see [SECURITY.md](.github/SECURITY.md)

## 📄 License

This project is licensed under the terms of the repository's main LICENSE file.

---
For more information, see the official documentation for [Redis](https://redis.io/docs/) and [RedisInsight](https://redis.io/docs/connect/insight/).
