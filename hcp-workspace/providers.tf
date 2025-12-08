provider "aws" {
  region = var.aws_region
}

provider "azurerm" {
  features {}
  # TODO: Needed?
  # resource_provider_registrations = "none"
}
