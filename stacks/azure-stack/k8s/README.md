# Azure Platform – Kubernetes Manifests (k3d)

Kubernetes manifests for deploying Azure emulators/simulators to a local k3d cluster.

## Services

| Service | Description | Internal Port | K8s Service |
|---|---|---|---|
| **Azurite** | Azure Storage emulator (Blob/Queue/Table) | 10000-10002 | `azurite:10000`, `azurite:10001`, `azurite:10002` |
| **CosmosDB** | Azure Cosmos DB emulator (vNext) | 8081/1234 | `cosmosdb:8081`, `cosmosdb:1234` |
| **Event Hubs** | Azure Event Hubs emulator | 5672/9092/5300 | `eventhubs:5672`, `eventhubs:9092` |
| **Service Bus** | Azure Service Bus emulator | 5671 | `servicebus:5671` |
| **SQL Server** | SQL Server 2022 Express | 1433 | `sqlserver:1433` |
| **App Configuration** | Azure App Configuration emulator | 8483 | `appconfig:8483` |

## Deploy

```bash
kubectl apply -f k8s/
```

Or individually in dependency order:

```bash
kubectl apply -f k8s/namespace.yml
kubectl apply -f k8s/configmap.yml
kubectl apply -f k8s/pvcs.yml
kubectl apply -f k8s/azurite.yml
kubectl apply -f k8s/sqlserver.yml
kubectl apply -f k8s/cosmosdb.yml
kubectl apply -f k8s/eventhubs.yml    # depends on azurite
kubectl apply -f k8s/servicebus.yml   # depends on sqlserver
kubectl apply -f k8s/appconfig.yml
```

## Cross-namespace Access

From other namespaces, use fully qualified DNS names:

```
azurite.azure-platform.svc.cluster.local:10000
cosmosdb.azure-platform.svc.cluster.local:8081
sqlserver.azure-platform.svc.cluster.local:1433
```

## Port Forwarding

```bash
kubectl port-forward -n azure-platform svc/azurite 10000:10000 10001:10001 10002:10002
kubectl port-forward -n azure-platform svc/cosmosdb 8081:8081 1234:1234
kubectl port-forward -n azure-platform svc/sqlserver 1434:1433
kubectl port-forward -n azure-platform svc/appconfig 8483:8483
```

## Cleanup

```bash
kubectl delete namespace azure-platform
```
