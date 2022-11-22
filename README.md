az login
az group create --name myResourceGroup --location eastus
az container create --resource-group myResourceGroup --name mycontainer --image mcr.microsoft.com/azuredocs/aci-helloworld --dns-name-label aci-demo01 --ports 80
az container create --resource-group myResourceGroup --name mytamayosi --image mcr.microsoft.com/azuredocs/aci-helloworld --dns-name-label tamayosi --ports 80
az container show --resource-group myResourceGroup --name mytamayosi --query "{FQDN:ipAddress.fqdn,ProvisioningState:provisioningState}" --out table
az container logs --resource-group myResourceGroup --name mytamayosi
az container delete --resource-group myResourceGroup --name mytamayosi

------
az group create --name ProjetoDOAI --location eastus
az acr create --resource-group ProjetoDOAI --name projetodoaifront --sku Basic
az acr create --resource-group ProjetoDOAI --name projetodoaiback --sku Basic
az acr create --resource-group ProjetoDOAI --name projetodoaidb --sku Basic
az acr login -n projetodoaifront --expose-token
az acr show --name projetodoaifront --query loginServer --output table
docker tag projetodoaifront projetodoaifront.azurecr.io/projetodoaifront:v1
az acr login --name projetodoaifront
docker push projetodoaifront.azurecr.io/projetodoaifront:v1
az acr repository list --name projetodoaifront --output table
az acr repository show-tags --name projetodoaifront --repository projetodoaifront --output table
--------
adriana_sumire@PANDATOP:~/dojo/front$ ./cria_usu.sh
WARNING: Creating 'acrpull' role assignment under scope '/subscriptions/af6bd41e-db72-4097-9a3f-44b684f4ff50/resourceGroups/ProjetoDOAI/providers/Microsoft.ContainerRegistry/registries/projetodoaifront'
WARNING: The output includes credentials that you must protect. Be sure that you do not include these credentials in your code or check the credentials into your source control. For more information, see https://aka.ms/azadsp-cli
Service principal ID: 827a7c17-9f8d-4b23-853c-8b05eb1bf3d0
Service principal password: kb48Q~Sj38hTOCfqYkph-BEIIEgUK4aj90F5IcXw
--------
az container create --resource-group ProjetoDOAI --name projetodoaifront --image projetodoaifront.azurecr.io/projetodoaifront:v1 --cpu 1 --memory 1 --registry-login-server projetodoaifront.azurecr.io --registry-username 827a7c17-9f8d-4b23-853c-8b05eb1bf3d0 --registry-password kb48Q~Sj38hTOCfqYkph-BEIIEgUK4aj90F5IcXw --ip-address Public --dns-name-label projetodoai --ports 80

az container exec --resource-group ProjetoDOAI --name projetodoaifront --exec-command "/bin/bash"



---------------------------
####################################################################################
az acr login -n projetodoaiback --expose-token
az acr show --name projetodoaiback --query loginServer --output table >> projetodoaiback.azurecr.io
docker build -f dockerfile.backend -t projetodoaiback:latest .
docker tag projetodoaiback projetodoaiback.azurecr.io/projetodoaiback:v1
az acr login --name projetodoaiback
docker push projetodoaiback.azurecr.io/projetodoaiback:v1
az acr repository list --name projetodoaiback --output table
az acr repository show-tags --name projetodoaiback --repository projetodoaiback --output table
./cria_usu.sh projetodoaiback
Service principal ID: 064f9052-e8de-434b-abfb-4725ec6e3c78
Service principal password: b418Q~pBQXFiRRDQTDR8zzsa5EKSs8OA1LmfobPu
az container create --resource-group ProjetoDOAI --name projetodoaiback --image projetodoaiback.azurecr.io/projetodoaiback:v1 --cpu 1 --memory 2 --registry-login-server projetodoaiback.azurecr.io --registry-username 064f9052-e8de-434b-abfb-4725ec6e3c78 --registry-password b418Q~pBQXFiRRDQTDR8zzsa5EKSs8OA1LmfobPu --ip-address Public --dns-name-label projetodoaiback --ports 5000 5001
{
  "containers": [
    {
      "command": null,
      "environmentVariables": [],
      "image": "projetodoaiback.azurecr.io/projetodoaiback:v1",
      "instanceView": {
        "currentState": {
          "detailStatus": "",
          "exitCode": null,
          "finishTime": null,
          "startTime": "2022-11-22T09:49:20.203000+00:00",
          "state": "Running"
        },
        "events": [
          {
            "count": 1,
            "firstTimestamp": "2022-11-22T09:48:28+00:00",
            "lastTimestamp": "2022-11-22T09:48:28+00:00",
            "message": "pulling image \"projetodoaiback.azurecr.io/projetodoaiback@sha256:5a7b032ec211336a43771daef9a679eaab9947d8710c63938a4feba84408679f\"",
            "name": "Pulling",
            "type": "Normal"
          },
          {
            "count": 1,
            "firstTimestamp": "2022-11-22T09:48:53+00:00",
            "lastTimestamp": "2022-11-22T09:48:53+00:00",
            "message": "Successfully pulled image \"projetodoaiback.azurecr.io/projetodoaiback@sha256:5a7b032ec211336a43771daef9a679eaab9947d8710c63938a4feba84408679f\"",
            "name": "Pulled",
            "type": "Normal"
          },
          {
            "count": 3,
            "firstTimestamp": "2022-11-22T09:49:02+00:00",
            "lastTimestamp": "2022-11-22T09:49:14+00:00",
            "message": "Started container",
            "name": "Started",
            "type": "Normal"
          },
          {
            "count": 3,
            "firstTimestamp": "2022-11-22T09:49:07+00:00",
            "lastTimestamp": "2022-11-22T09:49:19+00:00",
            "message": "Killing container with id 05fe39c26403cd9797a5c235be3897f81595e5b094796565ac52afac8455ce33.",
            "name": "Killing",
            "type": "Normal"
          }
        ],
        "previousState": {
          "detailStatus": "Completed",
          "exitCode": 0,
          "finishTime": "2022-11-22T09:49:20.203000+00:00",
          "startTime": "2022-11-22T09:49:14.153000+00:00",
          "state": "Terminated"
        },
        "restartCount": 3
      },
      "livenessProbe": null,
      "name": "projetodoaiback",
      "ports": [
        {
          "port": 5000,
          "protocol": "TCP"
        },
        {
          "port": 5001,
          "protocol": "TCP"
        }
      ],
      "readinessProbe": null,
      "resources": {
        "limits": null,
        "requests": {
          "cpu": 1.0,
          "gpu": null,
          "memoryInGb": 1.0
        }
      },
      "volumeMounts": null
    }
  ],
  "diagnostics": null,
  "dnsConfig": null,
  "encryptionProperties": null,
  "id": "/subscriptions/af6bd41e-db72-4097-9a3f-44b684f4ff50/resourceGroups/ProjetoDOAI/providers/Microsoft.ContainerInstance/containerGroups/projetodoaiback",
  "identity": null,
  "imageRegistryCredentials": [
    {
      "identity": null,
      "identityUrl": null,
      "password": null,
      "server": "projetodoaiback.azurecr.io",
      "username": "064f9052-e8de-434b-abfb-4725ec6e3c78"
    }
  ],
  "initContainers": [],
  "instanceView": {
    "events": [],
    "state": "Running"
  },
  "ipAddress": {
    "dnsNameLabel": "projetodoaiback",
    "fqdn": "projetodoaiback.eastus.azurecontainer.io",
    "ip": "20.120.56.8",
    "ports": [
      {
        "port": 5000,
        "protocol": "TCP"
      },
      {
        "port": 5001,
        "protocol": "TCP"
      }
    ],
    "type": "Public"
  },
  "location": "eastus",
  "name": "projetodoaiback",
  "osType": "Linux",
  "provisioningState": "Succeeded",
  "resourceGroup": "ProjetoDOAI",
  "restartPolicy": "Always",
  "sku": "Standard",
  "subnetIds": null,
  "tags": {},
  "type": "Microsoft.ContainerInstance/containerGroups",
  "volumes": null,
  "zones": null
}
az container exec --resource-group ProjetoDOAI --name projetodoaiback --exec-command "/bin/bash"
az container exec --resource-group ProjetoDOAI --name projetodoaiback --container-name projetodoaidb --exec-command "/bin/bash"
####################################################################################
az acr login -n projetodoaidb --expose-token
az acr show --name projetodoaidb --query loginServer --output table >> projetodoaidb.azurecr.io
docker build -f dockerfile.mysql -t projetodoaidb:latest .
docker tag projetodoaidb projetodoaidb.azurecr.io/projetodoaidb:v1
az acr login --name projetodoaidb
docker push projetodoaidb.azurecr.io/projetodoaidb:v1
az acr repository list --name projetodoaidb --output table
az acr repository show-tags --name projetodoaidb --repository projetodoaidb --output table
./cria_usu.sh projetodoaidb
Service principal ID: 63204808-4e5a-487b-bc95-17faa4e01260
Service principal password: c4o8Q~ZQ9lvaDEGmp_waVLcGuNgoHKYgOCet3ayT
az container create --resource-group ProjetoDOAI --name projetodoaidb --image projetodoaidb.azurecr.io/projetodoaidb:v1 --cpu 1 --memory 1 --registry-login-server projetodoaidb.azurecr.io --registry-username 63204808-4e5a-487b-bc95-17faa4e01260 --registry-password c4o8Q~ZQ9lvaDEGmp_waVLcGuNgoHKYgOCet3ayT --ip-address Public --dns-name-label projetodoaidb --ports 3306

  "containers": [
    {
      "command": null,
      "environmentVariables": [],
      "image": "projetodoaidb.azurecr.io/projetodoaidb:v1",
      "instanceView": {
        "currentState": {
          "detailStatus": "",
          "exitCode": null,
          "finishTime": null,
          "startTime": "2022-11-22T08:30:03.627000+00:00",
          "state": "Running"
        },
        "events": [
          {
            "count": 1,
            "firstTimestamp": "2022-11-22T08:29:36+00:00",
            "lastTimestamp": "2022-11-22T08:29:36+00:00",
            "message": "pulling image \"projetodoaidb.azurecr.io/projetodoaidb@sha256:5447944ac64b331fc024de08ebd3c2e2636da96a22ad99eecf3b25bd0cb15a94\"",
            "name": "Pulling",
            "type": "Normal"
          },
          {
            "count": 1,
            "firstTimestamp": "2022-11-22T08:29:55+00:00",
            "lastTimestamp": "2022-11-22T08:29:55+00:00",
            "message": "Successfully pulled image \"projetodoaidb.azurecr.io/projetodoaidb@sha256:5447944ac64b331fc024de08ebd3c2e2636da96a22ad99eecf3b25bd0cb15a94\"",
            "name": "Pulled",
            "type": "Normal"
          },
          {
            "count": 1,
            "firstTimestamp": "2022-11-22T08:30:03+00:00",
            "lastTimestamp": "2022-11-22T08:30:03+00:00",
            "message": "Started container",
            "name": "Started",
            "type": "Normal"
          }
        ],
        "previousState": null,
        "restartCount": 0
      },
      "livenessProbe": null,
      "name": "projetodoaidb",
      "ports": [
        {
          "port": 3306,
          "protocol": "TCP"
        }
      ],
      "readinessProbe": null,
      "resources": {
        "limits": null,
        "requests": {
          "cpu": 1.0,
          "gpu": null,
          "memoryInGb": 1.0
        }
      },
      "volumeMounts": null
    }
  ],
  "diagnostics": null,
  "dnsConfig": null,
  "encryptionProperties": null,
  "id": "/subscriptions/af6bd41e-db72-4097-9a3f-44b684f4ff50/resourceGroups/ProjetoDOAI/providers/Microsoft.ContainerInstance/containerGroups/projetodoaidb",
  "identity": null,
  "imageRegistryCredentials": [
    {
      "identity": null,
      "identityUrl": null,
      "password": null,
      "server": "projetodoaidb.azurecr.io",
      "username": "63204808-4e5a-487b-bc95-17faa4e01260"
    }
  ],
  "initContainers": [],
  "instanceView": {
    "events": [],
    "state": "Running"
  },
  "ipAddress": {
    "dnsNameLabel": "projetodoaidb",
    "fqdn": "projetodoaidb.eastus.azurecontainer.io",
    "ip": "20.120.125.215",
    "ports": [
      {
        "port": 3306,
        "protocol": "TCP"
      }
    ],
    "type": "Public"
  },
  "location": "eastus",
  "name": "projetodoaidb",
  "osType": "Linux",
  "provisioningState": "Succeeded",
  "resourceGroup": "ProjetoDOAI",
  "restartPolicy": "Always",
  "sku": "Standard",
  "subnetIds": null,
  "tags": {},
  "type": "Microsoft.ContainerInstance/containerGroups",
  "volumes": null,
  "zones": null
}
az container exec --resource-group ProjetoDOAI --name projetodoaidb --exec-command "/bin/bash"
-------------



















https://learn.microsoft.com/pt-br/azure/container-apps/storage-mounts-azure-files?tabs=bash
ex
RESOURCE_GROUP="my-container-apps-group"
ENVIRONMENT_NAME="my-storage-environment"
LOCATION="eastus"

RESOURCE_GROUP="ProjetoDOAI"
ENVIRONMENT_NAME="projetodoaidb_volume"
LOCATION="eastus"
STORAGE_ACCOUNT_NAME="projetodoai7571"
STORAGE_SHARE_NAME="projetodoai_share"

az group create   --name storage-resource-group   --location eastus
az group create   --name $RESOURCE_GROUP   --location $LOCATION   --query "properties.provisioningState"


az storage account create   --resource-group ProjetoDOAI   --name projetodoai7571   --location "eastus"   --kind StorageV2   --sku Standard_LRS   --enable-large-file-share   --query provisioningState


az storage share-rm create   --resource-group ProjetoDOAI  --storage-account projetodoai7571 --name $STORAGE_SHARE_NAME   --quota 5120   --enabled-protocols SMB   --output table

STORAGE_ACCOUNT_KEY=`az storage account keys list -n $STORAGE_ACCOUNT_NAME --query "[0].value" -o tsv`

STORAGE_MOUNT_NAME="projetodoaidb_mount"

az containerapp env storage set   --access-mode ReadWrite   --azure-file-account-name $STORAGE_ACCOUNT_NAME   --azure-file-account-key $STORAGE_ACCOUNT_KEY   --azure-file-share-name $STORAGE_SHARE_NAME   --storage-name $STORAGE_MOUNT_NAME   --name $ENVIRONMENT_NAME   --resource-group $RESOURCE_GROUP   --output table

az containerapp env storage set -g $RESOURCE_GROUP -n $ENVIRONMENT_NAME --storage-name $STORAGE_SHARE_NAME --access-mode ReadWrite --azure-file-account-key $STORAGE_ACCOUNT_KEY --azure-file-account-name $STORAGE_ACCOUNT_NAME  --azure-file-share-name $STORAGE_SHARE_NAME

az containerapp env storage set -g MyResourceGroup -n MyEnv --storage-name MyStorageName --access-mode ReadOnly --azure-file-account-key MyAccountKey --azure-file-account-name MyAccountName --azure-file-share-name MyShareName