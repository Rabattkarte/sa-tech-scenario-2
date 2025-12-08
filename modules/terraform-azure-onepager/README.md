# Terraform Azure One-Pager Module

This module creates a virtual network, subnet, network security group, public IP, NIC, and single Ubuntu 22.04 VM that serves a bundled `index.html` via nginx.

## Usage

```hcl
terraform {
  required_version = "~> 1.14.0"
}

provider "azurerm" {
  features {}
}

module "azure_onepager" {
  source = "app.terraform.io/<org>/terraform-azure-onepager/azurerm"

  identifier          = "sa-tech-scenario-2-tf"
  location            = "northeurope"
  vm_size             = "Standard_D2alds_v6"
  admin_username      = "azureuser"
  ssh_public_key      = "ssh-rsa AAAAB3Nz...replace-with-real-key user@example"
  allowed_cidr        = "0.0.0.0/0"
  vnet_address_prefix = "10.42.0.0/24"
  subnet_prefix       = "10.42.0.0/25"
}

output "website_url" {
  value = module.azure_onepager.website_url
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.14.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.55.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.55.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_security_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | Admin username for the VM. | `string` | `"azureuser"` | no |
| <a name="input_allowed_cidr"></a> [allowed\_cidr](#input\_allowed\_cidr) | CIDR block allowed inbound access on ports 22/80/443. | `string` | `"0.0.0.0/0"` | no |
| <a name="input_cost_center"></a> [cost\_center](#input\_cost\_center) | Cost center tag value. | `string` | `"demo"` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Additional tags merged into resources. | `map(string)` | `{}` | no |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | Identifier for the stack resources. | `string` | `"sa-tech-scenario-2-tf"` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region that hosts all resources. | `string` | `"northeurope"` | no |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | SSH public key (contents of id\_rsa.pub). | `string` | n/a | yes |
| <a name="input_subnet_prefix"></a> [subnet\_prefix](#input\_subnet\_prefix) | CIDR range for the public subnet. | `string` | `"10.42.0.0/25"` | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | Virtual machine size for the nginx host. | `string` | `"Standard_D2alds_v6"` | no |
| <a name="input_vnet_address_prefix"></a> [vnet\_address\_prefix](#input\_vnet\_address\_prefix) | CIDR range for the dedicated virtual network. | `string` | `"10.42.0.0/24"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | Public IPv4 address of the VM. |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | ID of the subnet. |
| <a name="output_vm_id"></a> [vm\_id](#output\_vm\_id) | ID of the Linux VM. |
| <a name="output_website_url"></a> [website\_url](#output\_website\_url) | HTTP URL for the one-pager. |
