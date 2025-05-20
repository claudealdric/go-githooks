#!/bin/sh

# Exit immediately if a command exits with a non-zero status
set -e

if [ ! -d ".git" ]; then
    echo "Error: This script must be run in the root of a Git repository."
    exit 1
fi

# Check if brew is installed and install it if not
if ! command -v brew &> /dev/null
then
	echo "Homebrew could not be found, installing..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Check if golangci-lint is installed and install it if not
if ! command -v golangci-lint &> /dev/null
then
	echo "golangci-lint could not be found, installing..."
	brew install golangci-lint
fi

# Install the Git hooks
echo "Installing Git hooks..."
git submodule add --force https://github.com/claudealdric/go-githooks.git .githooks
git config core.hooksPath .githooks
chmod +x .githooks/pre-commit
chmod +x .githooks/pre-push
echo "Installation successful!"

# Copy the golangci-lint config file to the root of the repository
if [ ! -f ".golangci.yml" ]; then
	echo "Copying golangci-lint config file..."
	curl -fsSL https://raw.githubusercontent.com/claudealdric/go-githooks/refs/heads/main/.golangci.yml -o .golangci.yml
	echo "Copied .golangci.yml into the root directory"
fi

# Copy the Makefile to the root of the repository if it doesn't already exist
if [ ! -f "Makefile" ]; then
	echo "Copying Makefile..."
	curl -fsSL https://raw.githubusercontent.com/claudealdric/go-githooks/refs/heads/main/Makefile -o Makefile
	echo "Copied Makefile into the root directory"
fi

# Copy load-env-vars-and-run.sh to the root of the repository if it doesn't already exist
if [ ! -f "load-env-vars-and-run.sh" ]; then
	echo "Copying run script..."
	curl -fsSL https://raw.githubusercontent.com/claudealdric/go-githooks/refs/heads/main/load-env-vars-and-run.sh -o load-env-vars-and-run.sh
	echo "Copied run script into the root directory"
fi

exit 0
