

# Tutorial: Deploy a multi-container group using Docker Compose
subscription = "<subscription>"
az login 
az account set --subscription $subscription
## Create Azure container registry
### https://learn.microsoft.com/en-us/azure/container-instances/tutorial-docker-compose
myResourceGroup=rg-web-dev-eu-001
acrName=acrmie
acrServer=acrmie.azurecr.io

az group create --name $myResourceGroup --location eastus
az acr create --resource-group $myResourceGroup --name $acrName --sku Basic

# Log in to container registry
az acr login --name $acrName


# Get application code
git clone https://github.com/wirasakEz/azure-voting-app-redis.git
cd azure-voting-app-redis

# Modify Docker compose file

# Run multi-container application locally
docker-compose up --build -d

# Tag a container image
docker images
az acr list --resource-group $myResourceGroup --query "[].{acrLoginServer:loginServer}" --output table
docker tag mcr.microsoft.com/azuredocs/azure-vote-front:v1 $acrServer/azure-vote-front:v1
docker images

# Push images to registry
docker push $acrServer/azure-vote-front:v1

# List images in registry
az acr repository list --name $acrName --output table
az acr repository show-tags --name $acrName --repository azure-vote-front --output table


# Tutorial: Deploy an Azure Kubernetes Service (AKS) cluster
https://learn.microsoft.com/en-us/azure/aks/tutorial-kubernetes-deploy-cluster?tabs=azure-cli

