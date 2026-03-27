# Azure VM + k3s (Terraform)

This project deploys **one Azure VM** with Terraform.
On first boot, it installs `k3s` and Python web app tools (`gradio`, `streamlit`).

- Base size: `Standard_D4s_v5` (4 vCPU / 16GB RAM)
- Goal: Run k3s + about 5 web services

See `WORKFLOW.md` for full steps and diagrams.

## Quick Start

```bash
az login
cd /Users/gichanlee/workspace/azure_infra
./scripts/deploy.sh
```

Destroy:

```bash
cd /Users/gichanlee/workspace/azure_infra
./scripts/destroy.sh
```
