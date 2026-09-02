#!/bin/bash
# 1. Login na Azure
az login

RM="rm561722"
RG="rg-cp4-cp"
ACR_NAME="acr${RM}cp4"
LOCATION="brazilsouth"

# 2. Criar Grupo de Recursos
az group create --name $RG --location $LOCATION

# 3. Criar o Azure Container Registry (ACR)
az acr create --resource-group $RG --name $ACR_NAME --sku Standard --location $LOCATION --admin-enabled true

# 4. Login no ACR criado
az acr login --name $ACR_NAME

docker build -f Dockerfile.mysql -t ${RM}-mysql:v1 .
docker build -f Dockerfile.api -t ${RM}-api:v1 .

LOGIN_SERVER=$(az acr show --name $ACR_NAME --query loginServer --output tsv)

docker tag ${RM}-mysql:v1 $LOGIN_SERVER/${RM}-mysql:v1
docker tag ${RM}-api:v1 $LOGIN_SERVER/${RM}-api:v1

docker push $LOGIN_SERVER/${RM}-mysql:v1
docker push $LOGIN_SERVER/${RM}-api:v1