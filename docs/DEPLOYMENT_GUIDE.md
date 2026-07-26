# Enterprise Landing Zone Deployment & Operational Guide

## Step-by-Step Deployment Procedure

### Step 1: Pre-Deployment Prerequisites Verification
Ensure you have authenticated to Azure with sufficient privileges (`Owner` or `User Access Administrator` + `Contributor` on target subscriptions):

```bash
az login
az account set --subscription "<YOUR_SUBSCRIPTION_ID>"
```

### Step 2: Initialize Remote State Infrastructure
Run the bootstrap script to create the lock-protected Azure Storage Account:

```bash
# On Linux/macOS:
./scripts/bootstrap.sh

# On Windows:
.\scripts\bootstrap.ps1
```

### Step 3: Deploy Connectivity Layer (Hub)
Navigate to the `terragrunt/connectivity` folder and initialize Terragrunt:

```bash
cd terragrunt/connectivity
terragrunt plan
terragrunt apply
```

### Step 4: Deploy Management & Operations Layer
Deploy centralized logging, monitoring, and policy guardrails:

```bash
cd ../management
terragrunt plan
terragrunt apply
```

### Step 5: Deploy Workload Spokes (`dev`, `test`, `uat`, `prod`)
Deploy target workload environments:

```bash
cd ../dev
terragrunt plan
terragrunt apply
```

### Step 6: Bootstrap Kubernetes Cluster with GitOps (ArgoCD)
Obtain credentials for your private AKS cluster via Azure Bastion or direct VPN/ExpressRoute:

```bash
az aks get-credentials --resource-group rg-alz-ai-dev-eus --name aks-alz-ai-dev-eus --private-cluster
kubectl apply -f gitops/bootstrap/argocd-app-of-apps.yaml
```
