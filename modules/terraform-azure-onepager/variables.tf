variable "location" {
  description = "Azure region that hosts all resources."
  type        = string
  default     = "northeurope"
}

variable "vm_size" {
  description = "Virtual machine size for the nginx host."
  type        = string
  default     = "Standard_D2alds_v6"
}

variable "admin_username" {
  description = "Admin username for the VM."
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "SSH public key (contents of id_rsa.pub)."
  type        = string
}

variable "allowed_cidr" {
  description = "CIDR block allowed inbound access on ports 22/80/443."
  type        = string
  default     = "0.0.0.0/0"
}

variable "vnet_address_prefix" {
  description = "CIDR range for the dedicated virtual network."
  type        = string
  default     = "10.42.0.0/24"
}

variable "subnet_prefix" {
  description = "CIDR range for the public subnet."
  type        = string
  default     = "10.42.0.0/25"
}

variable "identifier" {
  description = "Identifier for the stack resources."
  type        = string
  default     = "sa-tech-scenario-2-tf"
}

variable "cost_center" {
  description = "Cost center tag value."
  type        = string
  default     = "demo"
}

variable "extra_tags" {
  description = "Additional tags merged into resources."
  type        = map(string)
  default     = {}
}
