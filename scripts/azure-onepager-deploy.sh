#!/usr/bin/env bash
set -euo pipefail

AZ_RG="${AZ_RG:-sa-tech-scenario-2-arm}"
AZ_REGION="${AZ_REGION:-northeurope}"
AZ_DEPLOYMENT="${AZ_DEPLOYMENT:-arm-onepager}"
AZ_TEMPLATE="${AZ_TEMPLATE:-$(dirname "$(dirname "$0")")/azure-arm-onepager/azure-onepager.json}"
AZ_PARAMETERS="${AZ_PARAMETERS:-$(dirname "$(dirname "$0")")/azure-arm-onepager/parameters.example.json}"
CLOUD_INIT_PATH="${CLOUD_INIT_PATH:-$(dirname "$(dirname "$0")")/azure-arm-onepager/cloud-init.txt}"
AZ_SSH_KEY_PATH="${AZ_SSH_KEY_PATH:-$HOME/.ssh/id_rsa.pub}"

echo "Ensuring resource group '${AZ_RG}' exists in ${AZ_REGION}"
az group create --name "${AZ_RG}" --location "${AZ_REGION}" >/dev/null

if [[ ! -f "${AZ_SSH_KEY_PATH}" ]]; then
    echo "SSH public key not found at ${AZ_SSH_KEY_PATH}" >&2
    exit 1
fi

SSH_KEY_CONTENT=$(<"${AZ_SSH_KEY_PATH}")
CLOUD_INIT_BASE64=$(base64 <"${CLOUD_INIT_PATH}" | tr -d '\n')

PARAM_ARGS=()
if [[ -f "${AZ_PARAMETERS}" ]]; then
    PARAM_ARGS+=(--parameters @"${AZ_PARAMETERS}")
fi

echo "Deploying ARM template ${AZ_TEMPLATE} into ${AZ_RG}"
az deployment group create \
    --name "${AZ_DEPLOYMENT}" \
    --resource-group "${AZ_RG}" \
    --template-file "${AZ_TEMPLATE}" \
    "${PARAM_ARGS[@]}" \
    --parameters \
    sshPublicKey="${SSH_KEY_CONTENT}" \
    cloudInitBase64="${CLOUD_INIT_BASE64}"

echo
echo "Deployment outputs:"
az deployment group show \
    --name "${AZ_DEPLOYMENT}" \
    --resource-group "${AZ_RG}" \
    --query "properties.outputs"
