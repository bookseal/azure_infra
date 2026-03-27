# Workflow (Azure CLI + Terraform)

## 1) Full Flow

```mermaid
flowchart TD
    A[Prepare local env<br/>macOS + zsh] --> B[Install tools<br/>brew install azure-cli terraform]
    B --> C[Azure login<br/>az login]
    C --> D[Select subscription<br/>az account set]
    D --> E[Prepare Terraform vars<br/>terraform.tfvars]
    E --> F[terraform init]
    F --> G[terraform plan]
    G --> H[terraform apply]
    H --> I[VM created]
    I --> J[cloud-init runs<br/>install k3s + gradio + streamlit]
    J --> K[Deploy and run services]
```

## 2) Infrastructure

```mermaid
graph LR
    Internet((Internet)) --> PIP[Public IP]
    PIP --> NIC[Network Interface]
    NIC --> VM[Ubuntu 22.04 VM\nStandard_D4s_v5]
    VM --> K3S[k3s Single Node]
    VNET[VNet 10.30.0.0/16] --> SUBNET[Subnet 10.30.1.0/24]
    SUBNET --> NIC
    NSG[NSG\n22,80,443,6443,30000-32767,7860,8501] --> NIC
```

## 3) Current TODO

- [x] Install Azure CLI
- [x] Install Terraform
- [x] Write Terraform code (Azure VM + network + NSG)
- [x] Add cloud-init for k3s bootstrap
- [x] Add docs + Mermaid diagrams
- [ ] Run `az login` (user step)
- [ ] Run real `terraform apply`

## 4) Directory Structure

```text
azure_infra/
├── .gitignore
├── README.md
├── WORKFLOW.md
└── terraform/
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    ├── terraform.tfvars.example
    └── cloud-init/
        └── k3s-init.yaml
```

## 5) Run Steps

### 5-1. Azure login (user step)

```bash
az login
az account list --output table
az account set --subscription "<SUBSCRIPTION_NAME_OR_ID>"
```

### 5-2. Prepare Terraform variables

```bash
cd /Users/gichanlee/workspace/azure_infra/terraform
cp terraform.tfvars.example terraform.tfvars
```

Update at least these values in `terraform.tfvars`:
- `ssh_public_key`
- `k3s_api_allowed_cidr` (recommended: your public IP `/32`)

### 5-3. Deploy

```bash
terraform init
terraform plan -out tfplan
terraform apply tfplan
```

## 6) Check After Deploy

```bash
terraform output
ssh azureuser@<PUBLIC_IP>
sudo kubectl get nodes -o wide
sudo kubectl get pods -A
```

## 7) Performance Guide (k3s + ~5 web services)

- Recommended VM: `Standard_D4s_v5`
- Disk: `Premium_LRS` with 128GB+
- If load grows, scale up to `Standard_D8s_v5`
- For production, prefer Ingress + TLS over many open ports

## 8) Cost and Security Notes

- Do not keep `k3s_api_allowed_cidr` as `0.0.0.0/0`; limit to your IP
- For long-term use, close direct `7860`/`8501` access and route via Ingress
- To stop costs when done:

```bash
terraform destroy
```
