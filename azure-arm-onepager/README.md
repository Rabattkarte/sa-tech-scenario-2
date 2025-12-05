# Azure ARM One-Pager Stack

This directory mirrors the AWS CloudFormation solution by deploying a minimal Azure footprint for the `index.html` one pager:

## What gets created

- VNet + subnet with custom address space.
- Network Security Group allowing SSH/HTTP/HTTPS from a configurable CIDR.
- Dynamic public IP, NIC, and Ubuntu 22.04 VM.
- cloud-init (`customData`) that installs nginx, decodes the base64-encoded HTML, and writes it to `/var/www/html/index.html`.

## Template files

- `azure-onepager.json` – main ARM template.
- `parameters.example.json` – copy to `parameters.prod.json` (etc.) and fill your SSH public key plus optional overrides.

## Deploy with Azure CLI

```bash
export AZ_RG=sa-tech-scenario-2-arm
export AZ_REGION=northeurope
export AZ_DEPLOYMENT=arm-onepager
# Optional overrides:
# export CLOUD_INIT_PATH=./azure-arm-onepager/cloud-init.txt
# export AZ_PARAMETERS=./azure-arm-onepager/parameters.prod.json

./scripts/azure-onepager-deploy.sh
```

The script will:

1. Ensure the resource group exists.
2. Base64 encode `CLOUD_INIT_PATH` (defaults to the repo's `index.html`).
3. Call `az deployment group create` with the template + parameters.
4. Print the deployment outputs; open `websiteUrl` to view the page.

## Teardown

```bash
./scripts/azure-onepager-destroy.sh
```

This removes the entire resource group (adjust the script if you need more granular cleanup).
