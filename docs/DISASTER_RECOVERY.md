# Multi-Region Disaster Recovery (DR) Specification

## Recovery Point Objective (RPO) & Recovery Time Objective (RTO)
- **RPO Target**: < 15 Minutes for stateful model metadata and vector databases.
- **RTO Target**: < 1 Hour for full AKS cluster failover across paired Azure regions (e.g. `East US` -> `Central US`).

## Disaster Recovery Architecture Plan

1. **Geo-Redundant Remote State**: Terraform state stored in `Standard_ZRS` / `Standard_GZRS` Storage Accounts.
2. **Container Registry Geo-Replication**: ACR Premium configured with automatic multi-region geo-replication across paired locations.
3. **Backup Strategy**: Velero / Azure Backup for AKS persistent volumes and Kubernetes manifests.
4. **Traffic Management**: Azure Front Door Premium / Traffic Manager routing traffic to secondary active/passive region upon health check failures.
