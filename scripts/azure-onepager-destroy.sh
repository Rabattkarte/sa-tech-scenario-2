#!/usr/bin/env bash
set -euo pipefail

AZ_RG="${AZ_RG:-sa-tech-scenario-2-arm}"

echo "Checking if resource group '${AZ_RG}' exists..."
if ! az group show --name "${AZ_RG}"; then
    echo "Resource group '${AZ_RG}' does not exist. Nothing to delete."
    exit 0
fi

echo "Deleting resource group '${AZ_RG}' and all contained resources."
az group delete --name "${AZ_RG}" --yes
