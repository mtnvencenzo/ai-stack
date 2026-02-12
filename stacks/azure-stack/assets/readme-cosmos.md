
## Instructions for linux based image
https://learn.microsoft.com/en-us/azure/cosmos-db/emulator-linux



## Run the cosmos container

Follow the [readme guide](../README.md) to pull and run the containers


Note that the data explorer runs on the 1234 port http://localhost:1234/

The db runs on 8081 and its good practice to trust the certificate issued from CosmosDb

``` Trust the cosmos cert
curl --insecure https://localhost:8081/_explorer/emulator.pem > ~/emulatorcert.crt
sudo cp ~/emulatorcert.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates

```

Https is required - see the --protocol https argument.  Note if you have issues with the cert disable the certificate check in the cosmos setup when running locally.


## Emulator Connection Info
   ```
   AccountEndpoint=https://localhost:8081/;AccountKey=C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw==;
   ```
   - For detailed configuration and troubleshooting, see the [Cosmos DB Emulator Documentation](https://learn.microsoft.com/en-us/azure/cosmos-db/linux-emulator)


## Random Az Cli
**Cosmos Control Plane Roles / Info**

https://learn.microsoft.com/en-us/azure/cosmos-db/nosql/how-to-grant-control-plane-access?tabs=built-in-definition%2Ccsharp&pivots=azure-interface-cli

``` bash
az login

## List role definitions
az cosmosdb sql role definition list --resource-group "my-resource-group" --account-name "cosmos-001"

## Add the standard built in reader
az cosmosdb sql role assignment create --account-name cosmos-001 --resource-group 'my-resource-group' --role-definition-name 'Cosmos DB Built-in Data Reader' --scope '/subscriptions/1d9ecc00-242a-460d-8b08-b71db19f094e/resourceGroups/my-resource-group/providers/Microsoft.DocumentDB/databaseAccounts/cosmos-001' --principal-id '00000000-0000-4dc0-82e1-b35ca21a6709'

# Add the custom data reader role
az cosmosdb sql role assignment create --account-name cosmos-001 --resource-group 'my-resource-group' --role-definition-name 'Cosmos DB Custom Data Reader' --scope '/subscriptions/1d9ecc00-242a-460d-8b08-b71db19f094e/resourceGroups/my-resource-group/providers/Microsoft.DocumentDB/databaseAccounts/cosmos-001' --principal-id '00000000-0000-4dc0-82e1-b35ca21a6709'

# List role assignments
az cosmosdb sql role assignment list --account-name cosmos-001 --resource-group my-resource-group


# Delete a role assignment
az cosmosdb sql role assignment delete --account-name cosmos--001 --resource-group 'my-resource-group' --role-assignment-id '/subscriptions/1d9ecc00-242a-460d-8b08-b71db19f094e/resourceGroups/my-resource-group/providers/Microsoft.DocumentDB/databaseAccounts/cosmos-001/sqlRoleAssignments/00000000-0000-4c89-89ef-c8c89f9baee4'

```