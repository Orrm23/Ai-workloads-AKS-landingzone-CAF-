# Enterprise Azure Landing Zone for AI/ML on AKS

[![Terraform](https://img.shields.io/badge/Terraform->=1.13-purple.svg)](https://www.terraform.io/)
[![Terragrunt](https://img.shields.io/badge/Terragrunt->=0.70-blue.svg)](https://terragrunt.gruntwork.io/)
[![Azure CAF](https://img.shields.io/badge/Azure-CAF%20Compliant-0078D4.svg)](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/)
[![Security Compliance](https://img.shields.io/badge/Security-ISO27001%20%7C%20SOC2%20%7C%20HIPAA-green.svg)](#)

A complete, production-grade, enterprise-scale Azure Landing Zone built with **Terraform**, **Terragrunt**, **Azure DevOps / GitHub Actions**, and **GitOps (ArgoCD)**. Specially architected to host high-performance AI/ML workloads, Large Language Model (LLM) fine-tuning, vector search databases, and inference pipelines on private Azure Kubernetes Service (AKS).

---

## 🏛️ Architecture Overview

The Landing Zone implements an enterprise **Hub-and-Spoke** network topology following Microsoft Cloud Adoption Framework (CAF) and Azure Well-Architected Framework:

- **Connectivity Hub**: Azure Firewall Premium (IDPS, TLS Inspection), Azure Bastion Host, VPN / ExpressRoute ready, and Centralized Private DNS Zones.
- **Management Platform**: Log Analytics Workspace, Managed Prometheus, Azure Monitor, Application Insights, Managed Grafana, and Azure Policy Initiatives.
- **Workload Spokes (`dev`, `test`, `uat`, `prod`)**: Private AKS Clusters with Azure CNI Overlay, Workload Identity, KEDA, NVIDIA GPU Node Pools, Azure Container Registry Premium, Key Vault, and Azure AI Foundry / OpenAI integration.

```mermaid
graph TD
    subgraph "Hub VNet (10.200.0.0/16)"
        AFW[Azure Firewall Premium]
        BAS[Azure Bastion Host]
        PDNS[Centralized Private DNS Zones]
    end

    subgraph "Management VNet"
        LAW[Log Analytics Workspace]
        AMP[Managed Prometheus]
        GRAF[Managed Grafana]
    end

    subgraph "Production AI/AKS Spoke VNet (10.1.0.0/16)"
        subgraph "AKS Cluster (Private API Server)"
            SYS[System Node Pool - Ephemeral OS]
            USER[CPU User Node Pool]
            GPU[NVIDIA GPU Node Pool - AI/LLM]
            SPOT[Spot Node Pool - FinOps]
        end

        KV[Key Vault - Premium]
        ACR[Container Registry - Premium]
        AOAI[Azure OpenAI Service]
        AML[Azure ML Workspace]
    end

    AFW <-->|VNet Peering| AKS Cluster
    PDNS <-->|Private Endpoint DNS Link| KV
    PDNS <-->|Private Endpoint DNS Link| ACR
    PDNS <-->|Private Endpoint DNS Link| AOAI
    LAW <-->|Container Insights| AKS Cluster
```

---

## 📁 Repository Structure

```text
azure-landing-zone-aks-ai/
├── modules/                   # Reusable Modular Parent-Child Terraform Modules
│   ├── shared/                # Global CAF Naming, Tagging, Versions, Providers
│   ├── network/               # Virtual Network Module
│   ├── subnet/                # Dedicated Subnets & NSGs
│   ├── firewall/              # Azure Firewall Premium + Policy
│   ├── bastion/               # Azure Bastion Host
│   ├── private_dns/           # Private DNS Zones & VNet Links
│   ├── private_endpoint/      # Zero-Trust Private Endpoints
│   ├── nat_gateway/           # Egress Outbound NAT Gateway
│   ├── vnet_peering/          # Bidirectional Hub-Spoke Peering
│   ├── route_table/           # UDR Forced Tunneling Route Tables
│   ├── keyvault/              # Key Vault with RBAC & Soft Delete
│   ├── acr/                   # Azure Container Registry Premium
│   ├── log_analytics/         # Central Log Analytics Workspace
│   ├── monitor/               # Managed Prometheus & Managed Grafana
│   ├── identity/              # User-Assigned Managed Identity
│   ├── storage/               # Secure Storage Account for AI Datasets
│   ├── policy/                # Azure Policy Initiatives
│   ├── rbac/                  # Enterprise Least-Privilege RBAC
│   ├── defender/              # Microsoft Defender for Cloud
│   ├── aks/                   # Private AKS Engine with GPU Node Pools
│   ├── aks_addons/            # Workload Identity FIC & Extensions
│   └── ai_foundry/            # Azure OpenAI & Machine Learning Workspace
│
├── terragrunt/                # Environment Deployment Hierarchy
│   ├── root.hcl                # Global Backend & Provider Generator
│   ├── common/                # Shared Environment Variables
│   ├── connectivity/          # Hub Infrastructure Stack
│   ├── management/            # Operations & Observability Stack
│   ├── dev/                   # Development Spoke Stack
│   ├── test/                  # Testing Spoke Stack
│   ├── uat/                    # UAT Staging Spoke Stack
│   └── prod/                  # Production Mission-Critical Spoke Stack
│
├── .github/workflows/         # Reusable GitHub Actions CI/CD Pipelines
├── azure-pipelines/           # Reusable Azure DevOps Pipelines
├── gitops/                    # ArgoCD Bootstrap, Kyverno Policies, & AI Apps
├── scripts/                   # Automated PowerShell & Bash Bootstrapping
├── docs/                      # Enterprise Architecture Specs & Operational Runbooks
├── Makefile                   # Platform Engineering Task Automation
└── .pre-commit-config.yaml    # Git Code Quality Hooks
```

---

## 🚀 Getting Started

### 1. Prerequisites
- Azure CLI (`>= 2.60.0`)
- Terraform (`>= 1.13.0`)
- Terragrunt (`>= 0.70.0`)
- `kubectl` & `helm`

### 2. Bootstrap Azure Storage Backend
Run the automated bootstrap script to provision the Azure Remote State Storage Account:

```bash
# Linux / macOS
chmod +x scripts/bootstrap.sh
./scripts/bootstrap.sh

# Windows PowerShell
.\scripts\bootstrap.ps1
```

### 3. Deploy Environment Stack using Terragrunt
Deploy the Landing Zone layer by layer:

```bash
# 1. Deploy Connectivity Hub
cd terragrunt/connectivity
terragrunt apply

# 2. Deploy Management Stack
cd ../management
terragrunt apply

# 3. Deploy Production AI/AKS Spoke
cd ../prod
terragrunt apply
```

---

## 🔒 Security & Governance Baseline

- **Zero Public Access**: 100% of endpoints (Key Vault, ACR, OpenAI, Azure ML, Storage, AKS API) are accessible strictly via Private Endpoints and Private DNS.
- **Identity First**: Azure AD Workload Identity replaces static secrets. Azure RBAC authorization is enforced everywhere.
- **Compliance**: Mapped to CIS Azure Foundations Benchmark v2.0, ISO27001, SOC2 Type II, and HIPAA safeguard guidelines.

---

## 📚 Detailed Documentation

- 📐 [Architecture Specifications](file:///C:/Users/botan/.gemini/antigravity/scratch/azure-landing-zone-aks-ai/docs/ARCHITECTURE.md)
- 📖 [Deployment & Operations Guide](file:///C:/Users/botan/.gemini/antigravity/scratch/azure-landing-zone-aks-ai/docs/DEPLOYMENT_GUIDE.md)
- 🔐 [Security & Compliance Mapping](file:///C:/Users/botan/.gemini/antigravity/scratch/azure-landing-zone-aks-ai/docs/SECURITY_AND_COMPLIANCE.md)
- 🛠️ [Operational Runbook](file:///C:/Users/botan/.gemini/antigravity/scratch/azure-landing-zone-aks-ai/docs/OPERATIONAL_RUNBOOK.md)
- 💰 [FinOps & Cost Optimization](file:///C:/Users/botan/.gemini/antigravity/scratch/azure-landing-zone-aks-ai/docs/FINOPS_COST_OPTIMIZATION.md)
- 🚨 [Disaster Recovery Guide](file:///C:/Users/botan/.gemini/antigravity/scratch/azure-landing-zone-aks-ai/docs/DISASTER_RECOVERY.md)
