#!/usr/bin/env bash
# Enterprise Azure Landing Zone Bootstrap Script (Linux / macOS)
# Initializes Azure Remote State Backend and verifies prerequisites

set -euo pipefail

PREFIX="alz"
LOCATION="eastus"
LOCATION_SHORT="eus"
RG_NAME="rg-${PREFIX}-tfstate-${LOCATION_SHORT}"
STORAGE_NAME="${PREFIX}tfstate${LOCATION_SHORT}"
CONTAINER_NAME="tfstate"

echo "========================================================="
echo "   Azure Landing Zone Enterprise Automation Bootstrap   "
echo "========================================================="

# 1. Check Prerequisites
command -v az >/dev/null 2>&1 || { echo "Azure CLI is required but not installed. Aborting."; exit 1; }
command -v terraform >/dev/null 2>&1 || { echo "Terraform is required but not installed. Aborting."; exit 1; }
command -v terragrunt >/dev/null 2>&1 || { echo "Terragrunt is required but not installed. Aborting."; exit 1; }

# 2. Azure Login Check
echo "==> Verifying Azure CLI authentication state..."
SUBSCRIPTION_ID=$(az account show --query id -o tsv)
TENANT_ID=$(az account show --query tenantId -o tsv)
echo "Active Subscription: ${SUBSCRIPTION_ID}"
echo "Active Tenant:       ${TENANT_ID}"

# 3. Create Remote State Storage Account
echo "==> Ensuring Resource Group '${RG_NAME}' exists..."
az group create --name "${RG_NAME}" --location "${LOCATION}" --tags ManagedBy=Bootstrap Environment=Core

echo "==> Ensuring Storage Account '${STORAGE_NAME}' exists for Terraform state locking..."
az storage account create \
  --name "${STORAGE_NAME}" \
  --resource-group "${RG_NAME}" \
  --location "${LOCATION}" \
  --sku Standard_ZRS \
  --encryption-services blob \
  --min-tls-version TLS1_2 \
  --allow-blob-public-access false

echo "==> Creating Blob Container '${CONTAINER_NAME}'..."
az storage container create \
  --name "${CONTAINER_NAME}" \
  --account-name "${STORAGE_NAME}" \
  --auth-mode login

echo "========================================================="
echo " Bootstrap Complete! Remote Backend ready for Terragrunt. "
echo "========================================================="
