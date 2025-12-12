#!/usr/bin/env bash
set -euo pipefail

AZ_RG="${AZ_RG:-sa-tech-scenario-2-arm}"
OUTPUT_DIR="${OUTPUT_DIR:-$(dirname "$0")/../aztfexport-demo}"
PARALLELISM="${PARALLELISM:-15}"

# Check resource group exists and has resources. This is a prerequisite for the demo.
az group show --name "${AZ_RG}" >/dev/null || {
    echo "ERROR: Resource group '${AZ_RG}' not found. For this demo, you need to run 'azure-onepager-deploy.sh' first." >&2
    exit 1
}

echo "Exporting resources from '${AZ_RG}' to '${OUTPUT_DIR}'..."

# Export resources from the specified Azure resource group to HCL using aztfexport
aztfexport resource-group \
    --overwrite \
    --non-interactive \
    --hcl-only \
    --generate-import-block \
    --parallelism "${PARALLELISM}" \
    --output-dir "${OUTPUT_DIR}" \
    "${AZ_RG}"

# Format generated HCL files
echo "Formatting generated Terraform files..."
cd "${OUTPUT_DIR}"
terraform fmt -recursive

echo "Export completed: '${OUTPUT_DIR}'"
