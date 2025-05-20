#!/bin/bash

# Instructions: set the values enclosed in angle brackets (<>)
#
# For example:
# KEYVAULT_NAME="my-secret-keyvault"
# export DATABASE_PASSWORD=$(az keyvault secret show --vault-name $KEYVAULT_NAME --name postgres-password --query value -o tsv)

SERVICE_NAME=$(go list -m -f '{{.Path}}' | sed 's/.*\///' | sed 's/-go$//')

# Set the Key Vault name
KEYVAULT_NAME="<KEYVAULT_NAME>"

# Set the non-secret environment variables
export APP_CONFIG_DIR=$PWD

# Get the secrets and export them as environment variables
# Set the variable name and secret key
export SECRET_VARIABLE=$(az keyvault secret show --vault-name $KEYVAULT_NAME --name <secret-key> --query value -o tsv)

echo "Environment variables successfully loaded!"

# Execute the Go application with the environment variables set
go run ./cmd/$SERVICE_NAME/main.go
