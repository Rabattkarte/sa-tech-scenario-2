#!/usr/bin/env bash
set -euo pipefail

AZ_RG="${AZ_RG:-sa-tech-scenario-2-arm}"

if ! az group show --name "${AZ_RG}" >/dev/null 2>&1; then
    echo "Resource group '${AZ_RG}' does not exist. Nothing to delete."
    exit 0
fi

echo "Deleting resource group '${AZ_RG}'. This removes all contained resources."
az group delete --name "${AZ_RG}" --yes --no-wait
echo "Deletion started. Run 'az group wait --name ${AZ_RG} --deleted' to track progress."
