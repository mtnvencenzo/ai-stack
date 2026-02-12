
# Kafka Stack - Local Kafka Environment

This stack provides a Docker Compose setup for running a local Kafka environment in **two modes**:
- **KRaft mode** (no Zookeeper required, modern Kafka architecture with Schema Registry)
- **Zookeeper mode** (classic Kafka architecture with Schema Registry)

Both modes include a web-based Kafka UI for easy management and monitoring.



## 📁 Contents

- `docker-compose.yml`: Single-broker KRaft cluster (recommended for local development)
- `docker-compose-3broker.yml`: Three-broker KRaft cluster with high availability
- `docker-compose-zoo.yml`: Classic Zookeeper-based Kafka cluster with Schema Registry
- `scripts/kafka-kraft-start.sh`: Automated KRaft storage formatting script
- `assets/`: Architecture diagrams
- `README.md`: This documentation file

## ⚙️ Prerequisites

- Docker 24+ and Docker Compose v2

## 🏗️ Architecture

### KRaft Mode (No Zookeeper)
- **Kafka (KRaft mode)**: Distributed event streaming platform running in KRaft (Kafka Raft) mode with no Zookeeper dependency. Cluster ID is automatically formatted on first startup via the `kafka-kraft-start.sh` script.
- **Schema Registry**: Service for managing Avro, JSON, and Protobuf schemas for Kafka topics. Stores schemas in the `_schemas` internal topic.
- **Kafka UI**: Web-based interface for managing Kafka topics, consumers, schemas, and monitoring cluster health.

**Available Configurations:**
- **Single-broker** (`docker-compose.yml`): Optimized for local development with minimal resource usage and no coordination overhead
- **Three-broker** (`docker-compose-3broker.yml`): High availability setup with replication factor 3 for testing distributed scenarios

![Kafka Stack](./assets/kafka-stack-kraft.drawio.svg)

### Zookeeper Mode (Classic)
- **Zookeeper**: Centralized service for maintaining configuration information and providing distributed synchronization.
- **Kafka Broker**: Classic Kafka broker connected to Zookeeper.
- **Schema Registry**: Service for managing Avro schemas for Kafka topics.
- **Kafka UI**: Web-based interface for managing Kafka topics, consumers, and monitoring cluster health.

<br/>

![Kafka Stack](./assets/kafka-stack-zoo.drawio.svg)

All containers run within a dedicated `kafka-stack` Docker bridge network for inter-service communication.

## 🚀 Setup & Usage

> This setup is designed for local development and learning. Do not use in production environments.

---

### 1. Start the Kafka stack services

#### KRaft mode (single-broker, recommended):
```bash
docker compose up -d
```

#### KRaft mode (three-broker cluster):
```bash
docker compose -f docker-compose-3broker.yml up -d
```

#### Zookeeper mode:
```bash
docker compose -f docker-compose-zoo.yml up -d
```

---

### 2. Stop the services

#### KRaft mode (single-broker):
```bash
docker compose down -v
```

#### KRaft mode (three-broker):
```bash
docker compose -f docker-compose-3broker.yml down -v
```

#### Zookeeper mode:
```bash
docker compose -f docker-compose-zoo.yml down -v
```

---

### 3. Rebuild and restart a specific service

#### KRaft mode (single-broker):
```bash
docker compose up -d --force-recreate --no-deps --build <service_name>
```

#### KRaft mode (three-broker):
```bash
docker compose -f docker-compose-3broker.yml up -d --force-recreate --no-deps --build <service_name>
```

#### Zookeeper mode:
```bash
docker compose -f docker-compose-zoo.yml up -d --force-recreate --no-deps --build <service_name>
```

---

### 4. Check all services status
```bash
docker compose ps
```

## 🛠️ Customization

- Modify the relevant compose file to adjust service settings, ports, or environment variables.

## 📊 Service Endpoints & Ports

### KRaft Mode - Single Broker (`docker-compose.yml`)
Modern Kafka architecture with no Zookeeper dependency. Optimized for local development.

- **Docs:** [Kafka KRaft mode](https://kafka.apache.org/documentation/#kraft)
- **Kafka Broker:**
  - `localhost:9092` (PLAINTEXT - for local clients)
  - `kafka-broker-1:19092` (PLAINTEXT_INTERNAL - for inter-container communication)
  - `host.docker.internal:29092` (PLAINTEXT_DOCKER - for host applications accessing containerized Kafka)
- **Schema Registry:** [http://localhost:8988](http://localhost:8988)
  - API endpoint for schema management
  - Integrated with Kafka UI for schema browsing
- **Kafka UI:** [http://localhost:8088](http://localhost:8088)
  - Topic management, consumer groups, and schema registry UI

**Features:**
- Single-broker setup: Minimal resource usage, no coordination overhead
- Automatic KRaft storage formatting via custom entrypoint script
- Replication factor: 1 (suitable for local development)
- Cluster ID: `EmptNWtoR4GGWx-BH6nGLQ`

---

### KRaft Mode - Three Brokers (`docker-compose-3broker.yml`)
High availability KRaft cluster for testing distributed scenarios.

- **Docs:** [Kafka KRaft mode](https://kafka.apache.org/documentation/#kraft)
- **Kafka Brokers:**
  - Broker 1: `localhost:9092`, `kafka-broker-1:19092`, `host.docker.internal:29092`
  - Broker 2: `localhost:9094`, `kafka-broker-2:19092`, `host.docker.internal:29094`
  - Broker 3: `localhost:9096`, `kafka-broker-3:19092`, `host.docker.internal:29096`
- **Schema Registry:** [http://localhost:8988](http://localhost:8988)
- **Kafka UI:** [http://localhost:8088](http://localhost:8088)

**Features:**
- Three-broker cluster with quorum-based controller election
- Replication factor: 3, Min in-sync replicas: 2
- Enhanced timeout configurations for stable Docker networking
- Automatic KRaft storage formatting per broker
- Same Cluster ID across all brokers

---

### Zookeeper Mode (`docker-compose-zoo.yml`)
Classic Kafka stack with Zookeeper and Schema Registry.

- **Docs:** [Kafka with Zookeeper](https://docs.confluent.io/platform/current/installation/docker/docs/quickstart.html)
- **Ports:**
  - Zookeeper: `2181` (host) → `2181` (container)
  - Kafka Broker: `9092` (host) → `9092` (container), `29092` (host) → `29092` (container), `39092` (host) → `39092` (container)
  - Schema Registry: `8988` (host) → `8081` (container)
- **Kafka UI:** [http://localhost:8088](http://localhost:8088)

---


## ⚙️ Configuration Insights

### KRaft Mode
- All services are connected via the `kafka-stack` Docker bridge network.
- **Cluster ID** (`EmptNWtoR4GGWx-BH6nGLQ`): Shared across all KRaft brokers. Automatically formatted via the startup script.
- **Listeners**: Three listener protocols are configured for flexibility:
  - `PLAINTEXT`: For localhost connections (9092, 9094, 9096)
  - `PLAINTEXT_INTERNAL`: For container-to-container communication (19092, 19094, 19096)
  - `PLAINTEXT_DOCKER`: For host applications using `host.docker.internal` (29092, 29094, 29096)
- **Single-broker timeouts**: Default KRaft timeouts work well without tuning.
- **Three-broker timeouts**: Enhanced timeout configurations prevent election churn in Docker:
  - Election timeout: 10000ms
  - Fetch timeout: 5000ms  
  - Request timeout: 5000ms
- Ports can be changed in the relevant compose file as needed.
- Service dependencies are managed via `depends_on` in the compose files.

### Zookeeper Mode
- All services are connected via the `kafka-stack` Docker bridge network.
- **Zookeeper coordination**: Classic Kafka architecture where Zookeeper manages cluster metadata, controller election, and broker registration.
- **Listeners**: Three listener protocols configured:
  - `PLAINTEXT`: For localhost connections (9092)
  - `PLAINTEXT_INTERNAL`: For container-to-container communication (29092)
  - `PLAINTEXT_DOCKER`: For host applications using `host.docker.internal` (39092)
- **Schema Registry**: Stores schemas in the `_schemas` topic, accessible via Kafka UI and REST API on port 8988.
- **Healthchecks**: Services use healthcheck configurations to ensure proper startup order:
  - Zookeeper must be healthy before Kafka broker starts
  - Kafka broker must be healthy before Schema Registry and Kafka UI start
- Ports can be changed in the compose file as needed.
- Service dependencies are managed via `depends_on` with health conditions.

## 🌐 Community & Support

- 🤝 Contributing Guide – see [.github/CONTRIBUTING.md](.github/CONTRIBUTING.md)
- 🤗 Code of Conduct – see [.github/CODE_OF_CONDUCT.md](.github/CODE_OF_CONDUCT.md)
- 🆘 Support Guide – see [.github/SUPPORT.md](.github/SUPPORT.md)
- 🔒 Security Policy – see [.github/SECURITY.md](.github/SECURITY.md)

## 📄 License

This project is licensed under the terms of the repository's main LICENSE file.
