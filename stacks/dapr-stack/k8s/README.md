# Dapr Platform – Kubernetes Manifests (k3d)

Kubernetes manifests for deploying Dapr sidecar infrastructure to a local k3d cluster.

> **Note:** For production Dapr on Kubernetes, prefer the official [Dapr Helm chart](https://docs.dapr.io/operations/hosting/kubernetes/kubernetes-deploy/#install-with-helm).
> These manifests replicate the docker-compose setup for local development parity.

## Services

| Service | Description | Internal Port | K8s Service |
|---|---|---|---|
| **Dapr Placement** | Actor placement service | 50005 | `dapr-placement:50005` |
| **Dapr Scheduler** | Job scheduling service (with embedded etcd) | 50006/2379 | `dapr-scheduler:50006`, `dapr-scheduler:2379` |

## Deploy

```bash
kubectl apply -k k8s/
```

Or individually:

```bash
kubectl apply -f k8s/namespace.yml
kubectl apply -f k8s/pvcs.yml
kubectl apply -f k8s/dapr-placement.yml
kubectl apply -f k8s/dapr-scheduler.yml
```

## Cross-namespace Access

```
dapr-placement.dapr-platform.svc.cluster.local:50005
dapr-scheduler.dapr-platform.svc.cluster.local:50006
```

## Port Forwarding

```bash
kubectl port-forward -n dapr-platform svc/dapr-placement 50005:50005
kubectl port-forward -n dapr-platform svc/dapr-scheduler 50006:50006
```

## Cleanup

```bash
kubectl delete namespace dapr-platform
```
