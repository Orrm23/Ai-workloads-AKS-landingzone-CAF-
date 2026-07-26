# Enterprise Platform Engineering Operational Runbook

## Common Operational Procedures

### 1. Scaling GPU Node Pools for Large AI Workloads
To adjust GPU node pool limits during high-capacity model training or LLM fine-tuning:

1. Open `terragrunt/prod/terragrunt.hcl`.
2. Locate the `gpu_node_pool` block:
   ```hcl
   gpu_node_pool = {
     vm_size   = "Standard_NV36ads_A10_v5"
     min_count = 4
     max_count = 16
   }
   ```
3. Run `terragrunt apply` from `terragrunt/prod`.

---

### 2. Rotating Key Vault Keys & Managed Identity Credentials
- Key Vault secrets rotate automatically every 2 minutes via Key Vault CSI Driver secret rotation.
- Managed Identities use Azure AD OAuth 2.0 token exchanges with 1-hour expiration; no manual secret rotation required.

---

### 3. Emergency Incident Response: Isolating a Node Pool
If a compromised container is detected on a worker node:

```bash
# Cordon the node to prevent new pod scheduling
kubectl cordon <node-name>

# Drain active pods safely
kubectl drain <node-name> --ignore-daemonsets --delete-emptydir-data

# Delete node via Azure CLI for immediate replacement
az aks nodepool delete-nodes --resource-group rg-alz-ai-prod-eus --cluster-name aks-alz-ai-prod-eus --nodepool-name gpunode --nodes <node-name>
```
