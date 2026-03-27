# Azure VM + k3s (Terraform)

This project deploys one Azure VM with Terraform.
On first boot, it installs `k3s`, `gradio`, and `streamlit`.

- VM size: `Standard_D4s_v5` (4 vCPU / 16GB RAM)
- Goal: Run k3s and about 5 web services

See `WORKFLOW.md` for full steps and Mermaid diagrams.

## Quick Start

```bash
az login
cd /Users/gichanlee/workspace/azure_infra
./scripts/deploy.sh
```

## Destroy Resources

```bash
cd /Users/gichanlee/workspace/azure_infra
./scripts/destroy.sh
```
