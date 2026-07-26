# Security & Compliance Framework Alignment Matrix

## Compliance Standards Mapped
- **CIS Microsoft Azure Foundations Benchmark v2.0**
- **ISO/IEC 27001:2022**
- **SOC 2 Type II (Trust Services Criteria)**
- **HIPAA Safeguards (Health Insurance Portability and Accountability Act)**
- **NIST SP 800-53 Rev. 5**

---

## Technical Security Safeguards Implemented

| Domain | Control Description | Implementation Detail | Benchmark / Standard |
|--------|---------------------|-----------------------|----------------------|
| **Identity & Access** | Zero Hardcoded Passwords / Keys | Managed Identity + Azure AD Workload Identity | CIS 1.1 / ISO27001 A.9.2 |
| **Network Security** | No Public Endpoints | 100% Private Endpoints for PaaS (Key Vault, ACR, OpenAI) | CIS 6.1 / NIST SC-7 |
| **Edge Security** | Threat Intelligence & IDPS | Azure Firewall Premium with TLS Inspection | CIS 6.2 / SOC2 CC6.6 |
| **Data Protection** | Encryption at Rest & in Transit | TLS 1.2+ minimum, Azure Storage Service Encryption, CMK Ready | CIS 3.1 / HIPAA 164.312 |
| **Kubernetes Security** | Privilege Escalation Prohibition | Kyverno ClusterPolicies enforcing Restricted Pod Security | NIST SI-4 / CIS 5.1 |
| **Container Security** | Vulnerability & Image Scanning | Defender for Containers + ACR Image Cleaner | ISO27001 A.12.6 |
| **Audit Logging** | Centralized Immutable Logging | 90-Day Retention in Log Analytics Workspace | CIS 5.2 / SOC2 CC7.2 |
