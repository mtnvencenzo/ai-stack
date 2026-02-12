# Postgres Stack
This repo contains a Docker Compose setup for running PostgreSQL locally with pgAdmin for development and testing. It provides a simple, production-ready PostgreSQL environment with a web-based management UI.

![Postgres Architecture Diagram](./assets/postgres-stack.drawio.svg)

## ⚙️ Prerequisites

- [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/) installed on your machine.

## 🏗️ Architecture

This setup provides a local PostgreSQL development environment:

- **postgres** - PostgreSQL 16 database server (port 5432)
- **pgadmin** - pgAdmin 4 web UI for PostgreSQL management and monitoring (port 5050)

All containers run within a dedicated `app-internal-network` bridge network for secure inter-service communication. Data is persisted using Docker volumes for both PostgreSQL data and pgAdmin configuration.

## 🚀 Setup & Usage

> The setup in this repo is geared for local development usage and should not be considered for production without adjustments.

### 1. Create the external network:

If you haven't already created the `app-internal-network` network for your stack repositories, create it first:

```bash
docker network create app-internal-network
```

### 2. Start the PostgreSQL services:

```bash
docker compose up -d

# Or if the containers have already been created
docker compose start
```

This will start PostgreSQL and pgAdmin using the provided configuration and create the necessary network and volumes for data persistence.

To bring the compose down, use this command:

```bash
docker compose down -v
```

To force a rebuild and deploy of an individual container use this command:  

```bash
docker compose up -d --force-recreate --no-deps --build <service_name>
```

### 3. Verify Services are Running:
```bash
# Check all services status
docker compose ps

# Test PostgreSQL connection
docker exec postgres pg_isready -U admin -d postgres

# Or use psql directly
psql -h localhost -p 5432 -U admin -d postgres
```

## 📊 Service Endpoints & Ports

- **PostgreSQL Server**: `localhost:5432` (TCP)
  - Protocol: PostgreSQL Protocol
  - Default Database: `postgres`
  - Default User: `admin`
  - Default Password: `password`
  - Data persistence enabled
- **pgAdmin**: `http://localhost:5050` (HTTP)
  - Web UI for PostgreSQL management and monitoring
  - Default Email: `admin@admin.com`
  - Default Password: `password`

## 💾 Data Persistence

- **PostgreSQL Data**: Stored in `vol_postgres` Docker volume
  - All database data persists across container restarts
  - Located at `/var/lib/postgresql/data` inside the container
- **pgAdmin Data**: Stored in `vol_pgadmin` Docker volume
  - Preserves server connections, preferences, and settings

## 🔌 Connecting to PostgreSQL

### From pgAdmin
1. Open `http://localhost:5050` in your browser
2. Login with credentials: `admin@admin.com` / `password`
3. Right-click "Servers" → "Register" → "Server"
4. Under "General" tab: Name = `Local PostgreSQL`
5. Under "Connection" tab:
   - Host: `postgres` (container name within Docker network)
   - Port: `5432`
   - Username: `admin`
   - Password: `password`
   - Save password: ✓

### From Command Line
```bash
# Using psql
psql -h localhost -p 5432 -U admin -d postgres

# Using docker exec
docker exec -it postgres psql -U admin -d postgres
```

### From Application
```bash
# Connection String
postgresql://admin:password@localhost:5432/postgres

# Or with explicit parameters
Host: localhost
Port: 5432
Database: postgres
Username: admin
Password: password
```

## 🐞 Troubleshooting

- Check container logs for errors:
  ```bash
  docker compose logs
  
  # Or for a specific service
  docker compose logs postgres
  docker compose logs pgadmin
  ```
- Ensure no port conflicts with existing services on your machine (especially port 5432 for PostgreSQL).
- Validate that Docker has sufficient resources allocated for all containers.
- Check that volumes have proper permissions for data persistence.
- If pgAdmin cannot connect to PostgreSQL:
  - Verify both containers are on the same network: `docker network inspect app-internal-network`
  - Check PostgreSQL health: `docker exec postgres pg_isready -U admin -d postgres`
  - Use container name `postgres` as the host in pgAdmin, not `localhost`
- If the external network doesn't exist:
  - Create it manually: `docker network create app-internal-network`

## 🔐 Security Notes

⚠️ **Important**: The default credentials (`admin` / `password`) are for local development only. 

For production use:
- Change default credentials using environment variables in `docker-compose.yml`
- Use secrets management for sensitive data
- Enable SSL/TLS connections
- Implement proper network security and firewall rules
- Regularly update PostgreSQL and pgAdmin images

## 🌐 Community & Support

- 🤝 Contributing Guide – see [CONTRIBUTING.md](.github/CONTRIBUTING.md)
- 🤗 Code of Conduct – see [CODE_OF_CONDUCT.md](.github/CODE_OF_CONDUCT.md)
- 🆘 Support Guide – see [SUPPORT.md](.github/SUPPORT.md)
- 🔒 Security Policy – see [SECURITY.md](.github/SECURITY.md)

## 📄 License

This project is licensed under the terms of the repository's main LICENSE file.

---
For more information, see the official documentation for [PostgreSQL](https://www.postgresql.org/docs/) and [pgAdmin](https://www.pgadmin.org/docs/).