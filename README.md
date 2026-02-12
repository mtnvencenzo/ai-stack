# Platform Ops

A collection of Docker Compose stacks for local development environments. Each stack provides containerized infrastructure services commonly needed for application development and testing.

## Stacks

| Stack | Description |
|-------|-------------|
| [ai-stack](./ai-stack/README.md) | Local AI engineering environment with Ollama, Open WebUI, Qdrant vector database, Hugging Face Text Embeddings, and Langfuse for LLM observability |
| [azure-stack](./azure-stack/README.md) | Azure service emulators including Azurite (Blob/Queue/Table), CosmosDB, Event Hubs, Service Bus, SQL Server, and App Configuration |
| [dapr-stack](./dapr-stack/README.md) | Dapr self-hosted runtime with placement and scheduler services for distributed application development |
| [elastic-stack](./elastic-stack/README.md) | Elastic Stack with Elasticsearch, Elastic APM, Kibana, and OpenTelemetry Collector for observability |
| [kafka-stack](./kafka-stack/README.md) | Apache Kafka environment supporting KRaft and Zookeeper modes with Schema Registry and Kafka UI |
| [postgres-stack](./postgres-stack/README.md) | PostgreSQL 16 database with pgAdmin web UI for database management |
| [rabbitmq-stack](./rabbitmq-stack/README.md) | RabbitMQ message broker with management UI and SSL/TLS support |
| [redis-stack](./redis-stack/README.md) | Redis server with AOF persistence and RedisInsight web UI |
| [dev-certs](./dev-certs/README.md) | Development SSL certificates shared across docker compose stacks |

## Kubernetes

For setting up a local Kubernetes cluster using Docker and k3d, with Rancher for cluster management and ArgoCD for GitOps-based continuous delivery, see the [Kubernetes Installation Guide](./INSTALL_K8S.md).

## Prerequisites

- Docker 24+ and Docker Compose v2

## Usage

Each stack is self-contained with its own `docker-compose.yml` and documentation. Navigate to the stack directory and follow the README instructions to start the services.
