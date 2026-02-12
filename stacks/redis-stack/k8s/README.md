# Redis Platform – Kubernetes Manifests (k3d)

Kubernetes manifests for deploying Redis and Redis Insight to a local k3d cluster.

## Services

| Service | Description | Internal Port | K8s Service |
|---|---|---|---|
| **Redis** | In-memory data store (Alpine) | 6379 | `redis:6379` |
| **Redis Insight** | Web UI for Redis management | 5540 | `redis-insight:5540` |

## Deploy

```bash
kubectl apply -f k8s/
```

Or in dependency order:

```bash
kubectl apply -f k8s/namespace.yml
kubectl apply -f k8s/pvcs.yml
kubectl apply -f k8s/redis.yml
kubectl apply -f k8s/redis-insight.yml  # depends on redis
```

## Cross-namespace Access

```
redis.redis-platform.svc.cluster.local:6379
```

## Port Forwarding

```bash
kubectl port-forward -n redis-platform svc/redis 6379:6379
kubectl port-forward -n redis-platform svc/redis-insight 5540:5540
```

## Cleanup

```bash
kubectl delete namespace redis-platform
```
