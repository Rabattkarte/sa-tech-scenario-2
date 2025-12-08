output "aws_website_url" {
  description = "HTTP URL for the AWS one-pager."
  value       = module.aws_onepager.website_url
}

output "azure_website_url" {
  description = "HTTP URL for the Azure one-pager."
  value       = module.azure_onepager.website_url
}
