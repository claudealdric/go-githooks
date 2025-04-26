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

# Install the pre-commit hook
echo "Installing pre-commit hook..."
git submodule add --force https://github.com/claudealdric/go-githooks.git .githooks
git config core.hooksPath .githooks
chmod +x .githooks/pre-commit
chmod +x .githooks/pre-push
echo "Installation successful!"

# Copy the golangci-lint config file to the root of the repository
if [ ! -f ".golangci.yml" ]; then
	echo "Copying golangci-lint config file..."
	curl -fsSL https://raw.githubusercontent.com/claudealdric/go-githooks/refs/heads/main/.golangci.yml -o .golangci.yml
fi

exit 0

