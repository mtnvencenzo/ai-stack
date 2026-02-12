# Postgres Platform – Kubernetes Manifests (k3d)

Kubernetes manifests for deploying PostgreSQL and pgAdmin to a local k3d cluster.

## Services

| Service | Description | Internal Port | K8s Service |
|---|---|---|---|
| **PostgreSQL** | PostgreSQL 16 (Alpine) | 5432 | `postgres:5432` |
| **pgAdmin** | Web UI for PostgreSQL management | 80 | `pgadmin:5050` |

## Deploy

```bash
kubectl apply -k k8s/
```

Or in dependency order:

```bash
kubectl apply -f k8s/namespace.yml
kubectl apply -f k8s/configmap.yml
kubectl apply -f k8s/pvcs.yml
kubectl apply -f k8s/postgres.yml
kubectl apply -f k8s/pgadmin.yml    # depends on postgres
kubectl apply -f k8s/ingress.yml
```

## Cross-namespace Access

```
postgres.postgres-platform.svc.cluster.local:5432
```

## Access

### Web UI (via Ingress)

- **pgAdmin**: http://pgadmin.127.0.0.1.sslip.io:8080

### Port Forwarding (alternative)

```bash
kubectl port-forward -n postgres-platform svc/postgres 5432:5432
```

## Cleanup

```bash
kubectl delete namespace postgres-platform
```
