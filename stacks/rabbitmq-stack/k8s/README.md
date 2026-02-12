# RabbitMQ Platform – Kubernetes Manifests (k3d)

Kubernetes manifests for deploying RabbitMQ to a local k3d cluster.

## Services

| Service | Description | Internal Port | K8s Service |
|---|---|---|---|
| **RabbitMQ** | Message broker with management UI | 5672/15672 | `rabbitmq:5672`, `rabbitmq:15672` |

## Deploy

```bash
kubectl apply -f k8s/
```

## Cross-namespace Access

```
rabbitmq.rabbitmq-platform.svc.cluster.local:5672
```

## Port Forwarding

```bash
kubectl port-forward -n rabbitmq-platform svc/rabbitmq 5672:5672 15672:15672
```

## Management UI

After port-forwarding, access at http://localhost:15672
- **Username:** admin
- **Password:** password

## Cleanup

```bash
kubectl delete namespace rabbitmq-platform
```
