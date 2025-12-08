module "aws_onepager" {
  source  = "app.terraform.io/sa-tech-scenario-2/terraform-aws-onepager/aws"
  version = "~> 1.0.0"

  allowed_cidr       = var.aws_allowed_cidr
  cost_center        = var.aws_cost_center
  extra_tags         = var.aws_extra_tags
  instance_type      = var.aws_instance_type
  key_pair_name      = var.aws_key_pair_name
  identifier         = var.aws_identifier
  public_subnet_cidr = var.aws_public_subnet_cidr
  vpc_cidr           = var.aws_vpc_cidr
}

module "azure_onepager" {
  source  = "app.terraform.io/sa-tech-scenario-2/terraform-azure-onepager/azurerm"
  version = "~> 1.0.0"

  admin_username      = var.azure_admin_username
  allowed_cidr        = var.azure_allowed_cidr
  cost_center         = var.azure_cost_center
  extra_tags          = var.azure_extra_tags
  identifier          = var.azure_identifier
  location            = var.azure_location
  ssh_public_key      = var.azure_ssh_public_key
  subnet_prefix       = var.azure_subnet_prefix
  vm_size             = var.azure_vm_size
  vnet_address_prefix = var.azure_vnet_address_prefix
}

check "aws_health_check" {
  data "http" "aws_onepager" {
    url = module.aws_onepager.website_url
  }

  assert {
    condition     = data.http.aws_onepager.status_code == 200
    error_message = "${data.http.aws_onepager.url} (AWS) returned an unhealthy status code (${data.http.aws_onepager.status_code})"
  }
}

check "azure_health_check" {
  data "http" "azure_onepager" {
    url = module.azure_onepager.website_url
  }

  assert {
    condition     = data.http.azure_onepager.status_code == 200
    error_message = "${data.http.azure_onepager.url} (Azure) returned an unhealthy status code (${data.http.azure_onepager.status_code})"
  }
}

