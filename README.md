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