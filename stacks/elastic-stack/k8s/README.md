# Elastic Platform – Kubernetes Manifests (k3d)

Kubernetes manifests for deploying the Elastic observability stack to a local k3d cluster.

## Services

| Service | Description | Internal Port | K8s Service |
|---|---|---|---|
| **Elasticsearch** | Search & analytics engine | 9200 | `elasticsearch:9200` |
| **Kibana** | Visualization dashboard | 5601 | `kibana:5601` |
| **APM Server** | Application Performance Monitoring | 8200 | `apm-server:8200` |
| **OTel Collector** | OpenTelemetry Collector (contrib) | 4317/4318 | `otel-collector:4317`, `otel-collector:4318` |

## Deploy

```bash
kubectl apply -f k8s/
```

Or in dependency order:

```bash
kubectl apply -f k8s/namespace.yml
kubectl apply -f k8s/configmap.yml
kubectl apply -f k8s/pvcs.yml
kubectl apply -f k8s/elasticsearch.yml
kubectl apply -f k8s/kibana.yml         # depends on elasticsearch
kubectl apply -f k8s/apm-server.yml      # depends on elasticsearch + kibana
kubectl apply -f k8s/otel-collector.yml  # depends on apm-server
```

## Cross-namespace Access

From other namespaces, send telemetry to:

```
otel-collector.elastic-platform.svc.cluster.local:4317   # OTLP gRPC
otel-collector.elastic-platform.svc.cluster.local:4318   # OTLP HTTP
```

## Port Forwarding

```bash
kubectl port-forward -n elastic-platform svc/elasticsearch 9200:9200
kubectl port-forward -n elastic-platform svc/kibana 5601:5601
kubectl port-forward -n elastic-platform svc/otel-collector 4317:4317 4318:4318
```

## Cleanup

```bash
kubectl delete namespace elastic-platform
```
