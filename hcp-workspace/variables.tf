variable "aws_region" {
  description = "AWS region for the workspace."
  type        = string
  default     = "eu-west-1"
}

variable "aws_identifier" {
  description = "Identifier applied to AWS resources and tags."
  type        = string
  default     = "sa-tech-scenario-2-tf"
}

variable "aws_cost_center" {
  description = "Cost center tag for AWS resources."
  type        = string
  default     = "demo"
}

variable "aws_instance_type" {
  description = "EC2 instance type for the AWS one-pager."
  type        = string
  default     = "t3.micro"
}

variable "aws_allowed_cidr" {
  description = "CIDR allowed to reach the AWS instance on HTTP/HTTPS/SSH."
  type        = string
  default     = "0.0.0.0/0"
}

variable "aws_key_pair_name" {
  description = "Optional existing EC2 key pair name."
  type        = string
  default     = ""
}

variable "aws_vpc_cidr" {
  description = "CIDR range for the AWS VPC."
  type        = string
  default     = "10.42.0.0/24"
}

variable "aws_public_subnet_cidr" {
  description = "CIDR range for the AWS public subnet."
  type        = string
  default     = "10.42.0.0/25"
}

variable "aws_extra_tags" {
  description = "Additional tags merged into AWS resources."
  type        = map(string)
  default     = {}
}

variable "azure_location" {
  description = "Azure region for the workspace."
  type        = string
  default     = "northeurope"
}

variable "azure_identifier" {
  description = "Identifier used for Azure resources."
  type        = string
  default     = "sa-tech-scenario-2-tf"
}

variable "azure_cost_center" {
  description = "Cost center tag for Azure resources."
  type        = string
  default     = "demo"
}

variable "azure_vm_size" {
  description = "VM size for the Azure one-pager."
  type        = string
  default     = "Standard_D2alds_v6"
}

variable "azure_admin_username" {
  description = "Admin username for the Azure VM."
  type        = string
  default     = "azureuser"
}

variable "azure_ssh_public_key" {
  description = "SSH public key used for the Azure VM."
  type        = string
}

variable "azure_allowed_cidr" {
  description = "CIDR allowed inbound to Azure VM on HTTP/HTTPS/SSH."
  type        = string
  default     = "0.0.0.0/0"
}

variable "azure_vnet_address_prefix" {
  description = "CIDR for the Azure VNet."
  type        = string
  default     = "10.42.0.0/24"
}

variable "azure_subnet_prefix" {
  description = "CIDR for the Azure subnet."
  type        = string
  default     = "10.42.0.0/25"
}

variable "azure_extra_tags" {
  description = "Additional tags merged into Azure resources."
  type        = map(string)
  default     = {}
}
