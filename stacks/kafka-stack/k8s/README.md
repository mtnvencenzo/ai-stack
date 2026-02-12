# Kafka Platform – Kubernetes Manifests (k3d)

Kubernetes manifests for deploying Kafka to a local k3d cluster. Three overlay variants are available:

| Overlay | Description | Compose Equivalent |
|---|---|---|
| **kraft** | Single-node KRaft (default) | `docker-compose.yml` |
| **kraft-3broker** | 3-node KRaft cluster | `docker-compose-3broker.yml` |
| **zookeeper** | Zookeeper-based single broker | `docker-compose-zoo.yml` |

## Structure

```
k8s/
├── base/                      # Shared: namespace, schema-registry, kafka-ui, ingress
├── overlays/
│   ├── kraft/                  # Single-node KRaft broker
│   ├── kraft-3broker/          # 3-node KRaft cluster
│   └── zookeeper/             # Zookeeper + single broker
└── README.md
```

## Services

| Service | Description | Internal Port | K8s Service |
|---|---|---|---|
| **Kafka Broker** | Confluent Kafka | 9092/19092 | `kafka-broker-1:9092`, `kafka-broker-1:19092` |
| **Schema Registry** | Confluent Schema Registry | 8081 | `schema-registry:8081` |
| **Kafka UI** | Web UI for Kafka management | 8080 | `kafka-ui:8088` |
| **Zookeeper** *(zoo overlay only)* | Apache Zookeeper | 2181 | `zookeeper:2181` |

## Deploy

Pick an overlay:

```bash
# KRaft single-node (default)
kubectl apply -k k8s/overlays/kraft/

# KRaft 3-broker cluster
kubectl apply -k k8s/overlays/kraft-3broker/

# Zookeeper-based
kubectl apply -k k8s/overlays/zookeeper/
```

> **Note:** Only deploy one overlay at a time — they share the same namespace and resource names.

## Cross-namespace Access

```
kafka-broker-1.kafka-platform.svc.cluster.local:19092   # Internal listener
schema-registry.kafka-platform.svc.cluster.local:8081
```

## Access

### Web UI (via Ingress)

- **Kafka UI**: http://kafka-ui.127.0.0.1.sslip.io:8080

### Port Forwarding (alternative)

```bash
kubectl port-forward -n kafka-platform svc/kafka-broker-1 9092:9092
kubectl port-forward -n kafka-platform svc/schema-registry 8988:8081
```

## Cleanup

```bash
kubectl delete namespace kafka-platform
```
