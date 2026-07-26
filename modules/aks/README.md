# Azure Kubernetes Service (AKS) Parent Module

## Purpose
Provisions an Enterprise-Scale Private Azure Kubernetes Service (AKS) cluster hardened for high-performance AI/ML model inference, fine-tuning, and microservice workloads.

## Features
- **Zero-Trust Network Topology**: Private API server, Azure CNI Overlay, Cilium Network Policy.
- **Identity & Access**: Azure AD Workload Identity, OIDC Issuer, Managed Kubelet Identity.
- **Node Pool Multi-Tenancy**:
  - `system`: Ephemeral OS disk, Availability Zone distribution, critical add-ons only.
  - `user`: Standard CPU compute workloads.
  - `gpu`: NVIDIA GPU node pool (e.g. `Standard_NC6s_v3`) with taints and labels for LLMs.
  - `spot`: FinOps-optimized spot node pool for batch job autoscaling.
- **Addons & Governance**: Defender for Containers, Azure Policy, Image Cleaner, Key Vault CSI Driver.

## Requirements
| Name | Version |
|------|---------|
| terraform | >= 1.13.0 |
| azurerm | ~> 4.20.0 |
