# Azure VM + k3s Infrastructure with Terraform

This project demonstrates how to use **Terraform** to provision and manage cloud infrastructure on Azure. It deploys a single Ubuntu VM configured with k3s (lightweight Kubernetes) and Python web application tools.

## What is Terraform?

[Terraform](https://www.terraform.io/) is an infrastructure-as-code (IaC) tool that lets you define and provision cloud infrastructure using declarative configuration files. Instead of manually clicking through a cloud console, you write code that describes your desired infrastructure, and Terraform creates it for you.

**Key benefits:**
- **Version Control**: Your infrastructure is defined in code, trackable in Git
- **Reproducible**: Deploy identical environments consistently
- **Automated**: No manual clicking through cloud consoles
- **Safe**: Preview changes before applying them

## Project Overview

This repository deploys:
- **1 Azure Virtual Machine** running Ubuntu 22.04
- **VM Size**: `Standard_D4s_v5` (4 vCPU / 16GB RAM)
- **Networking**: VNet, subnet, public IP, and security group
- **Software**: k3s (lightweight Kubernetes) + Gradio & Streamlit
- **Goal**: Host approximately 5 web services on a single VM

## Repository Structure

```
azure_infra/
├── README.md                    # This file - project overview
├── WORKFLOW.md                  # Detailed Terraform workflow guide
├── scripts/
│   ├── deploy.sh               # Automated deployment script
│   └── destroy.sh              # Automated teardown script
└── terraform/
    ├── main.tf                 # Main infrastructure definitions
    ├── variables.tf            # Input variables declaration
    ├── outputs.tf              # Output values after deployment
    ├── terraform.tfvars.example # Example configuration file
    └── cloud-init/
        └── k3s-init.yaml       # VM bootstrap script
```

### Key Files Explained

- **`main.tf`**: Defines Azure resources (VM, network, storage, etc.)
- **`variables.tf`**: Declares input parameters (VM size, region, SSH key, etc.)
- **`outputs.tf`**: Defines what information to display after deployment (IP address, connection info)
- **`terraform.tfvars`**: Your actual configuration values (created from `.example`)
- **`cloud-init/k3s-init.yaml`**: Script that runs on first boot to install k3s

## Quick Start

### Prerequisites

- **Azure CLI**: `brew install azure-cli`
- **Terraform**: `brew install terraform`
- **SSH Key**: `~/.ssh/id_rsa.pub` (generate with `ssh-keygen` if needed)

### Deploy Infrastructure

```bash
# 1. Authenticate with Azure
az login

# 2. Deploy everything
cd /Users/gichanlee/workspace/azure_infra
./scripts/deploy.sh
```

The script will:
1. Initialize Terraform
2. Format and validate configuration
3. Show you a preview of changes
4. Apply the changes to create resources
5. Display connection information

### Destroy Infrastructure

When you're done, tear down all resources to stop costs:

```bash
./scripts/destroy.sh
```

## What Happens During Deployment?

1. **Terraform reads** your configuration files (`*.tf`)
2. **Terraform plans** what needs to be created/changed
3. **You review** the plan before applying
4. **Terraform creates** resources in Azure (VM, network, etc.)
5. **Cloud-init runs** on the VM to install k3s and tools
6. **You get outputs** like the VM's public IP address

## Next Steps

- 📖 **Read [WORKFLOW.md](./WORKFLOW.md)** for detailed step-by-step instructions
- 🔧 Learn how to customize VM size, region, and security settings
- 🎨 Understand the infrastructure diagrams
- 🚀 Learn Terraform commands and best practices

## Quick Reference

| Command | Purpose |
|---------|---------|
| `terraform init` | Initialize Terraform (download providers) |
| `terraform plan` | Preview changes before applying |
| `terraform apply` | Create/update infrastructure |
| `terraform destroy` | Delete all managed resources |
| `terraform output` | Show output values (IPs, etc.) |

## Cost Warning ⚠️

This VM costs money while running (~$100-150/month for `Standard_D4s_v5`). Always run `terraform destroy` when you're done experimenting!

---

**For complete workflow, troubleshooting, and advanced usage, see [WORKFLOW.md](./WORKFLOW.md)**
