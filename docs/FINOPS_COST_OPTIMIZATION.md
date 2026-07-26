# FinOps & Cost Optimization Architecture Specification

## Financial Operations (FinOps) Best Practices

### 1. Multi-Tier Node Pool Strategy
To balance high performance with enterprise cost efficiency:

- **System Pool (`Standard_D4s_v5`)**: 3 small nodes for control plane critical add-ons.
- **Spot Node Pool (`Standard_D4s_v5` Spot Priority)**: Used for batch processing, offline model evaluation, and background ETL jobs. Saves up to **60-80%** compared to on-demand pricing.
- **Auto-scaling GPU Pool (`Standard_NC6s_v3`)**: `min_count` scaled to 0 or 1 in dev/test, automatically scaling up only when KEDA detects incoming prompt token queues.

### 2. Azure Reservations & Savings Plans
- Recommend **1-Year or 3-Year Azure Compute Savings Plans** for baseline AKS CPU system/user node pools and Azure Firewall Premium instances to save up to **40-65%**.

### 3. Automated Storage Lifecycle Rules
- Blob Storage containers configured with lifecycle management policies: move raw datasets to `Cool` tier after 30 days and `Archive` tier after 90 days.
