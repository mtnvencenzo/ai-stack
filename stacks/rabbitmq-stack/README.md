
# RabbitMQ Stack - Local RabbitMQ Environment

This stack provides a Docker Compose setup for running a local RabbitMQ environment with management UI and SSL/TLS support for secure messaging.

![RabbitMq Stack](./assets/rabbitmq-stack.drawio.svg)

## 📁 Contents

- `docker-compose.yml`: RabbitMQ with management plugin enabled
- `rabbitmq.conf`: RabbitMQ configuration for SSL/TLS support
- `assets/`: Architecture diagrams
- `README.md`: This documentation file

## ⚙️ Prerequisites

- Docker 24+ and Docker Compose v2
- SSL certificates for secure connections (optional, see Configuration section)

## 🏗️ Architecture

- **RabbitMQ**: Message broker implementing the Advanced Message Queuing Protocol (AMQP) with support for multiple messaging protocols
- **Management UI**: Web-based interface for managing queues, exchanges, bindings, users, and monitoring cluster health
- **SSL/TLS Support**: Secure connections using custom certificates for encrypted messaging

All containers run within a dedicated `rabbitmq-network` Docker bridge network for inter-service communication.

<br/>

## 🚀 Setup & Usage

> This setup is designed for local development and learning. Do not use in production environments without proper security hardening.

---

### 1. Start the RabbitMQ stack

```bash
docker compose up -d
```

---

### 2. Stop the services

```bash
docker compose down -v
```

---

### 3. Rebuild and restart the service

```bash
docker compose up -d --force-recreate --no-deps --build rabbitmq
```

---

### 4. Check service status
```bash
docker compose ps
```

## 🛠️ Customization

- Modify `docker-compose.yml` to adjust service settings, ports, or environment variables
- Edit `rabbitmq.conf` to configure SSL/TLS settings and other RabbitMQ parameters
- Change default credentials via environment variables `RABBITMQ_DEFAULT_USER` and `RABBITMQ_DEFAULT_PASS`

## 📊 Service Endpoints & Ports

- **Docs:** [RabbitMQ Documentation](https://www.rabbitmq.com/documentation.html)
- **AMQP Protocol (SSL/TLS only):** `localhost:5671`
  - Secure AMQP port for encrypted client connections
  - Requires SSL certificates configured in `rabbitmq.conf`
  - Non-SSL port (5672) is disabled for security
- **Management UI:** [http://localhost:15672](http://localhost:15672)
  - Default credentials: `admin` / `password`
  - Queue, exchange, and binding management
  - User and virtual host management
  - Cluster monitoring and metrics

**Features:**
- RabbitMQ 4 with management plugin
- SSL/TLS support for secure messaging
- Health checks for container reliability
- Persistent storage for message durability
- Custom hostname: `rabbitmq.docker.local`

## 🔒 SSL/TLS Configuration

The stack is configured to support SSL/TLS connections using custom certificates. The certificates are mounted from:

```
${DOCKER_LOCAL_CERT_PATH:-$HOME/Github/dev-certs/docker-local}/
```

**Certificate files required:**
- `docker-local.crt` - Server certificate
- `docker-local.key` - Private key

**SSL Configuration** (in `rabbitmq.conf`):
- SSL listener on port 5671
- Client certificate verification disabled by default (`verify_none`)
- Suitable for development; enable strict verification for production

## 📝 Default Credentials

- **Username:** `admin`
- **Password:** `password`

⚠️ **Change these credentials** in production environments by modifying the environment variables in `docker-compose.yml`.

## 🔍 Monitoring & Management

Access the RabbitMQ Management UI at [http://localhost:15672](http://localhost:15672) to:
- View and manage queues, exchanges, and bindings
- Monitor message rates and queue depths
- Manage users and permissions
- View connection and channel statistics
- Configure policies and parameters

## 📦 Volumes

The stack uses named volumes for data persistence:
- `vol_rabbitmq-lib`: RabbitMQ data directory (message store, metadata)
- `vol_rabbitmq-logs`: RabbitMQ log files

## 🧪 Testing Connections

### SSL Connection (required)
```bash
# Using Python pika with SSL
pip install pika
python -c "import pika, ssl; context = ssl.create_default_context(); context.check_hostname = False; context.verify_mode = ssl.CERT_NONE; connection = pika.BlockingConnection(pika.ConnectionParameters('localhost', 5671, credentials=pika.PlainCredentials('admin', 'password'), ssl_options=pika.SSLOptions(context))); print('Connected via SSL!')"
```

**Note:** Non-SSL connections on port 5672 are disabled. All client connections must use SSL/TLS on port 5671.

## ⚙️ Configuration Details

- RabbitMQ runs within the `rabbitmq-network` Docker bridge network
- **Custom hostname**: `rabbitmq.docker.local` for consistent DNS resolution
- **Health checks**: Container readiness verified via `rabbitmq-diagnostics check_port_connectivity`
- **Persistent volumes**: 
  - Message data and metadata stored in `vol_rabbitmq-lib`
  - Logs stored in `vol_rabbitmq-logs`
- **SSL/TLS**: Configured via `rabbitmq.conf` with custom certificates
- **Default vhost**: `/` (can be customized via configuration)
- Ports can be changed in `docker-compose.yml` as needed

## 🌐 Community & Support

- 🤝 Contributing Guide – see [.github/CONTRIBUTING.md](.github/CONTRIBUTING.md)
- 🤗 Code of Conduct – see [.github/CODE_OF_CONDUCT.md](.github/CODE_OF_CONDUCT.md)
- 🆘 Support Guide – see [.github/SUPPORT.md](.github/SUPPORT.md)
- 🔒 Security Policy – see [.github/SECURITY.md](.github/SECURITY.md)

## 📄 License

This project is licensed under the terms of the repository's main LICENSE file.
