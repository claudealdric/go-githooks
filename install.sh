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

# Check for the .githooks directory and create it if it doesn't exist
if [ ! -d ".githooks" ]; then
	echo "Creating .githooks directory..."
	mkdir .githooks
fi

# Install the pre-commit hook
echo "Installing pre-commit hook..."
curl -fsSL https://raw.githubusercontent.com/claudealdric/go-githooks/refs/heads/main/pre-commit -o .githooks/pre-commit
chmod +x .githooks/pre-commit
git config core.hooksPath .githooks

echo "Installation successful!"
exit 0
