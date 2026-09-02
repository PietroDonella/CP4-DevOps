#!/bin/bash
RM="rm561722"
RG="rg-cp4-cp"
LOCATION="brazilsouth"
STORAGE_ACCOUNT="st${RM}cp4"
SHARE_NAME="mysql-volume"

# Criar Storage Account
az storage account create --resource-group $RG --name $STORAGE_ACCOUNT --location $LOCATION --sku Standard_LRS

# Criar o File Share para o volume do banco
az storage share create --name $SHARE_NAME --account-name $STORAGE_ACCOUNT