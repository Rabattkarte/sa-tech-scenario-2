# Sentinel Policy Set for Compliance

This directory contains Sentinel policies that enforce compliance standards for AWS and Azure deployments.

## Policies

### `enforce-tagging-aws.sentinel`

**Enforcement Level:** Soft Mandatory

Enforces that all taggable AWS resources must have the following required tags:

- `Project`
- `ManagedBy`
- `CostCenter`

### `enforce-tagging-azure.sentinel`

**Enforcement Level:** Soft Mandatory

Enforces that all taggable Azure resources must have the following required tags:

- `Project`
- `ManagedBy`
- `CostCenter`
- `Owner`

### `validate-regions-aws.sentinel`

**Enforcement Level:** Hard Mandatory

Restricts AWS deployments to approved regions:

**Allowed AWS Regions:**

- `eu-west-1` (Ireland)
- `eu-central-1` (Frankfurt)
- `us-west-2` (Oregon)

The policy checks the `aws_region` variable. If the variable is not set (empty string), the policy passes to allow workspaces that don't use AWS.

### `validate-regions-azure.sentinel`

**Enforcement Level:** Hard Mandatory

Restricts Azure deployments to approved regions:

**Allowed Azure Regions:**

- `northeurope` (Ireland)
- `westeurope` (Netherlands)
- `centralus` (Iowa)

The policy checks the `azure_location` variable. If the variable is not set (empty string), the policy passes to allow workspaces that don't use Azure.
