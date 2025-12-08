# Terraform AWS One-Pager Module

This module creates a VPC, subnet, internet gateway, route table, security group, and single Amazon Linux 2023 instance that serves a bundled `index.html` via nginx.

## Usage

```hcl
terraform {
  required_version = "~> 1.14.0"
}

provider "aws" {
  region = var.aws_region
}

module "aws_onepager" {
  source = "app.terraform.io/<org>/terraform-aws-onepager/aws"

  identifier         = "sa-tech-scenario-2-tf"
  instance_type      = "t3.micro"
  allowed_cidr       = "0.0.0.0/0"
  key_pair_name      = "" # optional
  vpc_cidr           = "10.42.0.0/24"
  public_subnet_cidr = "10.42.0.0/25"
}

output "website_url" {
  value = module.aws_onepager.website_url
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.14.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.25.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 6.25.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_route.default_ipv4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_ssm_parameter.ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_cidr"></a> [allowed\_cidr](#input\_allowed\_cidr) | CIDR allowed to reach the instance on HTTP/HTTPS/SSH. | `string` | `"0.0.0.0/0"` | no |
| <a name="input_ami_ssm_parameter"></a> [ami\_ssm\_parameter](#input\_ami\_ssm\_parameter) | SSM Parameter Store path that resolves to the desired AMI. | `string` | `"/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64"` | no |
| <a name="input_cost_center"></a> [cost\_center](#input\_cost\_center) | Cost center tag value. | `string` | `"demo"` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Additional tags merged into every supported resource. | `map(string)` | `{}` | no |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | Identifier applied to AWS resources and tags. | `string` | `"sa-tech-scenario-2-tf"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 instance type used for the nginx host. | `string` | `"t3.micro"` | no |
| <a name="input_key_pair_name"></a> [key\_pair\_name](#input\_key\_pair\_name) | Existing EC2 key pair name to associate with the instance. | `string` | `""` | no |
| <a name="input_public_subnet_cidr"></a> [public\_subnet\_cidr](#input\_public\_subnet\_cidr) | CIDR range for the public subnet. | `string` | `"10.42.0.0/25"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR range for the dedicated VPC. | `string` | `"10.42.0.0/24"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | EC2 instance ID. |
| <a name="output_instance_public_ip"></a> [instance\_public\_ip](#output\_instance\_public\_ip) | Public IPv4 address of the EC2 instance. |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | Public subnet ID. |
| <a name="output_website_url"></a> [website\_url](#output\_website\_url) | HTTP URL for the one-pager. |
