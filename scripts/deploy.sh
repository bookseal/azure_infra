#!/usr/bin/env zsh
set -euo pipefail

PROJECT_DIR="/Users/gichanlee/workspace/azure_infra/terraform"
SSH_KEY_PATH="${HOME}/.ssh/id_rsa.pub"

if [[ ! -f "${SSH_KEY_PATH}" ]]; then
  echo "SSH public key not found: ${SSH_KEY_PATH}"
  echo "Generate one first: ssh-keygen -t ed25519 -C \"azure-k3s\""
  exit 1
fi

cd "${PROJECT_DIR}"

rm -f .terraform.tfstate.lock.info terraform.tfstate.lock.info

terraform init
terraform fmt -recursive
terraform validate
terraform plan -lock=false -out tfplan -var="ssh_public_key=$(cat "${SSH_KEY_PATH}")"
terraform apply -lock=false tfplan

terraform output
