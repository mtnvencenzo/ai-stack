# Kafka Platform – Kubernetes Manifests (k3d)

Kubernetes manifests for deploying Kafka (KRaft mode) to a local k3d cluster.

## Services

| Service | Description | Internal Port | K8s Service |
|---|---|---|---|
| **Kafka Broker** | Confluent Kafka (KRaft, single node) | 9092/19092 | `kafka-broker-1:9092`, `kafka-broker-1:19092` |
| **Schema Registry** | Confluent Schema Registry | 8081 | `schema-registry:8081` |
| **Kafka UI** | Web UI for Kafka management | 8080 | `kafka-ui:8088` |

## Deploy

```bash
kubectl apply -f k8s/
```

Or in dependency order:

```bash
kubectl apply -f k8s/namespace.yml
kubectl apply -f k8s/configmap.yml
kubectl apply -f k8s/pvcs.yml
kubectl apply -f k8s/kafka-broker.yml
kubectl apply -f k8s/schema-registry.yml  # depends on kafka
kubectl apply -f k8s/kafka-ui.yml          # depends on kafka + schema-registry
```

## Cross-namespace Access

```
kafka-broker-1.kafka-platform.svc.cluster.local:19092   # Internal listener
schema-registry.kafka-platform.svc.cluster.local:8081
```

## Port Forwarding

```bash
kubectl port-forward -n kafka-platform svc/kafka-broker-1 9092:9092
kubectl port-forward -n kafka-platform svc/schema-registry 8988:8081
kubectl port-forward -n kafka-platform svc/kafka-ui 8088:8088
```

## Cleanup

```bash
kubectl delete namespace kafka-platform
```
