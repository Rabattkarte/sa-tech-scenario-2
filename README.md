# sa-tech-scenario-2

This repository contains infrastructure-as-code examples demonstrating a migration journey from traditional cloud-native templates (CloudFormation and ARM) to a unified HCP Terraform approach.

## Directory Structure

### 📁 [`aws-cloudformation-onepager`](aws-cloudformation-onepager)

Original AWS CloudFormation template for the one-pager application.

**Pain Points Demonstrated:**

- Lengthy YAML configuration.
- Cannot update user data without full stack replacement.
- Requires custom bash scripts for deployment.
- No built-in policy enforcement.
- AWS-specific; knowledge not transferable to Azure.

### 📁 [`azure-arm-onepager`](azure-arm-onepager)

Original Azure ARM template for the same one-pager application.

**Pain Points Demonstrated:**

- Complex JSON syntax.
- Difficult to read and maintain.
- Requires custom bash scripts for deployment.
- No cross-cloud consistency with AWS approach.
- Azure-specific; separate tooling from AWS.

### 📁 [`scripts`](scripts)

Deployment and teardown scripts for CloudFormation and ARM templates. These scripts represent the "old way" of managing infrastructure - custom bash scripts wrapping cloud-native CLIs. With HCP Terraform, these scripts become obsolete; all deployment logic is in the Terraform configuration.

**Migration Tools:**

- `azure-onepager-aztfexport.sh` - Exports existing Azure resources (created via ARM templates) to Terraform HCL configuration using `aztfexport`. This demonstrates how to migrate ARM-managed infrastructure to Terraform.

### 📁 [`modules`](modules)

Reusable Terraform modules that replace CloudFormation and ARM templates.

#### 📁 [`modules/terraform-aws-onepager`](modules/terraform-aws-onepager)

Terraform module equivalent to the CloudFormation stack:

- More concise code base
- Easier to read and maintain (HCL vs YAML)
- Supports incremental updates (no need to destroy/recreate for user data changes)
- Can be published to HCP Terraform private registry
- Reusable across multiple projects

#### 📁 [`modules/terraform-azure-onepager`](modules/terraform-azure-onepager)

Terraform module equivalent to the ARM template:

- Smaller and more readable than JSON
- Consistent structure with AWS module
- Same HCL syntax as AWS (single language for both clouds)
- Can be published to HCP Terraform private registry
- Reusable across multiple projects

### 📁 [`hcp-workspace`](hcp-workspace)

HCP Terraform workspace configuration demonstrating multi-cloud deployment. This configuration uses both modules from the HCP Terraform private registry to deploy the one-pager application to both AWS and Azure simultaneously from a single configuration.

### 📁 [`hcp-query`](hcp-query)

Examples using `terraform query` (and `terraform import` to some extend) to discover existing cloud resources. This demonstrates how one can discover and potentially import existing CloudFormation and ARM-managed resources into Terraform state.

**Related:** The `azure-onepager-aztfexport.sh` script in the [`scripts`](scripts) directory provides an automated way to export entire Azure resource groups to Terraform configuration, complementing the manual import process shown here.
