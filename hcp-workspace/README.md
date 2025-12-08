# HCP Terraform Workspace Configuration

This workspace uses two private registry modules to deploy a one-pager website in both AWS and Azure.

## Prerequisites

- HCP Terraform organization with access to the private modules `terraform-aws-onepager` and `terraform-azure-onepager`.
- AWS credentials configured for the workspace.
- Azure credentials configured for the workspace.
- SSH public key available for the Azure VM.

## Notes

- Module sources use the HCP private registry format: `app.terraform.io/<org>/terraform-aws-onepager/aws` and `app.terraform.io/<org>/terraform-azure-onepager/azurerm`. Update this slug accordingly for your organization.
- Pin module versions as needed by editing `version` in `main.tf`.

## Usage

1. Add workspace environment variables to override default values.
1. Ensure workspace environment variables are set for AWS and Azure authentication.
1. Run `terraform init && terraform apply` (locally) or trigger a run in HCP Terraform.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.14.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_onepager"></a> [aws\_onepager](#module\_aws\_onepager) | app.terraform.io/sa-tech-scenario-2/terraform-aws-onepager/aws | ~> 1.0.0 |
| <a name="module_azure_onepager"></a> [azure\_onepager](#module\_azure\_onepager) | app.terraform.io/sa-tech-scenario-2/terraform-azure-onepager/azurerm | ~> 1.0.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_allowed_cidr"></a> [aws\_allowed\_cidr](#input\_aws\_allowed\_cidr) | CIDR allowed to reach the AWS instance on HTTP/HTTPS/SSH. | `string` | `"0.0.0.0/0"` | no |
| <a name="input_aws_cost_center"></a> [aws\_cost\_center](#input\_aws\_cost\_center) | Cost center tag for AWS resources. | `string` | `"demo"` | no |
| <a name="input_aws_extra_tags"></a> [aws\_extra\_tags](#input\_aws\_extra\_tags) | Additional tags merged into AWS resources. | `map(string)` | `{}` | no |
| <a name="input_aws_identifier"></a> [aws\_identifier](#input\_aws\_identifier) | Identifier applied to AWS resources and tags. | `string` | `"sa-tech-scenario-2-tf"` | no |
| <a name="input_aws_instance_type"></a> [aws\_instance\_type](#input\_aws\_instance\_type) | EC2 instance type for the AWS one-pager. | `string` | `"t3.micro"` | no |
| <a name="input_aws_key_pair_name"></a> [aws\_key\_pair\_name](#input\_aws\_key\_pair\_name) | Optional existing EC2 key pair name. | `string` | `""` | no |
| <a name="input_aws_public_subnet_cidr"></a> [aws\_public\_subnet\_cidr](#input\_aws\_public\_subnet\_cidr) | CIDR range for the AWS public subnet. | `string` | `"10.42.0.0/25"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region for the workspace. | `string` | `"eu-west-1"` | no |
| <a name="input_aws_vpc_cidr"></a> [aws\_vpc\_cidr](#input\_aws\_vpc\_cidr) | CIDR range for the AWS VPC. | `string` | `"10.42.0.0/24"` | no |
| <a name="input_azure_admin_username"></a> [azure\_admin\_username](#input\_azure\_admin\_username) | Admin username for the Azure VM. | `string` | `"azureuser"` | no |
| <a name="input_azure_allowed_cidr"></a> [azure\_allowed\_cidr](#input\_azure\_allowed\_cidr) | CIDR allowed inbound to Azure VM on HTTP/HTTPS/SSH. | `string` | `"0.0.0.0/0"` | no |
| <a name="input_azure_cost_center"></a> [azure\_cost\_center](#input\_azure\_cost\_center) | Cost center tag for Azure resources. | `string` | `"demo"` | no |
| <a name="input_azure_extra_tags"></a> [azure\_extra\_tags](#input\_azure\_extra\_tags) | Additional tags merged into Azure resources. | `map(string)` | `{}` | no |
| <a name="input_azure_identifier"></a> [azure\_identifier](#input\_azure\_identifier) | Identifier used for Azure resources. | `string` | `"sa-tech-scenario-2-tf"` | no |
| <a name="input_azure_location"></a> [azure\_location](#input\_azure\_location) | Azure region for the workspace. | `string` | `"northeurope"` | no |
| <a name="input_azure_ssh_public_key"></a> [azure\_ssh\_public\_key](#input\_azure\_ssh\_public\_key) | SSH public key used for the Azure VM. | `string` | n/a | yes |
| <a name="input_azure_subnet_prefix"></a> [azure\_subnet\_prefix](#input\_azure\_subnet\_prefix) | CIDR for the Azure subnet. | `string` | `"10.42.0.0/25"` | no |
| <a name="input_azure_vm_size"></a> [azure\_vm\_size](#input\_azure\_vm\_size) | VM size for the Azure one-pager. | `string` | `"Standard_D2alds_v6"` | no |
| <a name="input_azure_vnet_address_prefix"></a> [azure\_vnet\_address\_prefix](#input\_azure\_vnet\_address\_prefix) | CIDR for the Azure VNet. | `string` | `"10.42.0.0/24"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_website_url"></a> [aws\_website\_url](#output\_aws\_website\_url) | HTTP URL for the AWS one-pager. |
| <a name="output_azure_website_url"></a> [azure\_website\_url](#output\_azure\_website\_url) | HTTP URL for the Azure one-pager. |
