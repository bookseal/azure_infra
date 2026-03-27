#!/usr/bin/env zsh
set -euo pipefail

PROJECT_DIR="/Users/gichanlee/workspace/azure_infra/terraform"
SSH_KEY_PATH="${HOME}/.ssh/id_rsa.pub"

cd "${PROJECT_DIR}"
rm -f .terraform.tfstate.lock.info terraform.tfstate.lock.info
terraform destroy -lock=false -var="ssh_public_key=$(cat "${SSH_KEY_PATH}")"
