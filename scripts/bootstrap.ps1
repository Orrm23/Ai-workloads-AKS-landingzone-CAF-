# Enterprise Azure Landing Zone Bootstrap Script (PowerShell for Windows)
# Initializes Azure Remote State Backend and verifies prerequisites

$ErrorActionPreference = "Stop"

$Prefix = "alz"
$Location = "eastus"
$LocationShort = "eus"
$RgName = "rg-$Prefix-tfstate-$LocationShort"
$StorageName = "$Prefix" + "tfstate" + "$LocationShort"
$ContainerName = "tfstate"

Write-Host "=========================================================" -ForegroundColor Cyan
Write-Host "   Azure Landing Zone Enterprise Automation Bootstrap   " -ForegroundColor Cyan
Write-Host "=========================================================" -ForegroundColor Cyan

# 1. Check Azure CLI Login
$Account = az account show --query "{sub:id, tenant:tenantId}" -o json | ConvertFrom-Json
Write-Host "Active Subscription: $($Account.sub)" -ForegroundColor Green
Write-Host "Active Tenant:       $($Account.tenant)" -ForegroundColor Green

# 2. Create Resource Group
Write-Host "==> Ensuring Resource Group '$RgName' exists..." -ForegroundColor Yellow
az group create --name $RgName --location $Location --tags ManagedBy=Bootstrap Environment=Core

# 3. Create Storage Account
Write-Host "==> Ensuring Storage Account '$StorageName' exists..." -ForegroundColor Yellow
az storage account create `
  --name $StorageName `
  --resource-group $RgName `
  --location $Location `
  --sku Standard_ZRS `
  --encryption-services blob `
  --min-tls-version TLS1_2 `
  --allow-blob-public-access false

# 4. Create Blob Container
Write-Host "==> Creating Blob Container '$ContainerName'..." -ForegroundColor Yellow
az storage container create `
  --name $ContainerName `
  --account-name $StorageName `
  --auth-mode login

Write-Host "=========================================================" -ForegroundColor Cyan
Write-Host " Bootstrap Complete! Remote Backend ready for Terragrunt. " -ForegroundColor Green
Write-Host "=========================================================" -ForegroundColor Cyan
