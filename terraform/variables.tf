variable "location" {
  description = "Azure region"
  type        = string
  default     = "koreacentral"
}

variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "k3s-lab"
}

variable "admin_username" {
  description = "Admin username for VM"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "SSH public key for VM login"
  type        = string
}

variable "vm_size" {
  description = "VM size adequate for k3s + ~5 web services"
  type        = string
  default     = "Standard_D4s_v5"
}

variable "os_disk_size_gb" {
  description = "OS disk size in GB"
  type        = number
  default     = 128
}

variable "vnet_cidr" {
  description = "VNet CIDR"
  type        = string
  default     = "10.30.0.0/16"
}

variable "subnet_cidr" {
  description = "Subnet CIDR"
  type        = string
  default     = "10.30.1.0/24"
}

variable "k3s_api_allowed_cidr" {
  description = "CIDR allowed to access k3s API port 6443"
  type        = string
  default     = "0.0.0.0/0"
}

variable "timezone" {
  description = "Timezone for VM"
  type        = string
  default     = "Asia/Seoul"
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default = {
    project     = "k3s-web-lab"
    managed_by  = "terraform"
    environment = "dev"
  }
}
