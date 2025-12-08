# Sentinel Policy Set Configuration for HCP Terraform

policy "enforce-tagging-aws" {
  source            = "./enforce-tagging-aws.sentinel"
  enforcement_level = "soft-mandatory"
}

policy "enforce-tagging-azure" {
  source            = "./enforce-tagging-azure.sentinel"
  enforcement_level = "soft-mandatory"
}

policy "validate-regions-aws" {
  source            = "./validate-regions-aws.sentinel"
  enforcement_level = "hard-mandatory"
}

policy "validate-regions-azure" {
  source            = "./validate-regions-azure.sentinel"
  enforcement_level = "hard-mandatory"
}
