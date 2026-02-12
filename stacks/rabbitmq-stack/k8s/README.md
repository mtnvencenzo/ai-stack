# RabbitMQ Platform – Kubernetes Manifests (k3d)

Kubernetes manifests for deploying RabbitMQ to a local k3d cluster.

## Services

| Service | Description | Internal Port | K8s Service |
|---|---|---|---|
| **RabbitMQ** | Message broker with management UI | 5672/15672 | `rabbitmq:5672`, `rabbitmq:15672` |

## Deploy

```bash
kubectl apply -k k8s/
```

Or individually:

```bash
kubectl apply -f k8s/namespace.yml
kubectl apply -f k8s/configmap.yml
kubectl apply -f k8s/pvcs.yml
kubectl apply -f k8s/rabbitmq.yml
kubectl apply -f k8s/ingress.yml
```

## Cross-namespace Access

```
rabbitmq.rabbitmq-platform.svc.cluster.local:5672
```

## Access

### Management UI (via Ingress)

- **RabbitMQ Management**: http://rabbitmq.127.0.0.1.sslip.io:8080
  - **Username:** admin
  - **Password:** password

### Port Forwarding (alternative)

```bash
kubectl port-forward -n rabbitmq-platform svc/rabbitmq 5672:5672
```

## Cleanup

```bash
kubectl delete namespace rabbitmq-platform
```
