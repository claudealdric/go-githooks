# Go Git Hooks

A collection of Git hooks for Go projects to enforce code quality, consistency,
and correctness. These hooks include pre-commit and pre-push checks tailored for
Go development.

## Features

### Pre-Commit Hook

The pre-commit hook ensures that staged changes meet the project's quality
standards before committing. It performs the following tasks:

- **Run `golangci-lint`**: Lints only the staged changes to catch issues early.
- **Format Staged Files**: Uses `golangci-lint fmt` to format staged `.go` files
  and re-adds them to the staging area.

### Pre-Push Hook

The pre-push hook validates the entire codebase before pushing changes to a
remote repository. It performs the following checks:

- **Run `go vet`**: Identifies potential issues in the code.
- **Run Tests**: Executes all tests in the project.
- **Check for Race Conditions**: Runs tests with the `-race` flag to detect race
  conditions.
- **Build the Project**: Ensures the project builds successfully.
- **Verify Dependencies**: Ensures `go.mod` and `go.sum` are clean and
  up-to-date.

## Installation

Run the following command to install the hooks and their dependencies:

```bash
curl -fsSL https://raw.githubusercontent.com/claudealdric/go-githooks/main/install.sh | sh
```

### What This Script Does

1. Installs `Homebrew` (if not already installed).
2. Installs `golangci-lint` using Homebrew.
3. Adds the hooks as a Git submodule in the `.githooks` directory.
4. Configures Git to use the `.githooks` directory for hooks.
5. Installs the pre-commit and pre-push hooks.
6. Copies the `golangci-lint` configuration file (`.golangci.yml`) to the root
   of your repository (if it doesn't exist).
7. Copies the `Makefile` to the root of your repository (if it doesn't exist).
8. Copies the `load-env-vars-and-run.sh` script to the root of your repository
   (if it doesn't exist).

## Usage

### Pre-Commit Hook

The pre-commit hook runs automatically when you attempt to commit changes. It
ensures that:

- Staged `.go` files are linted and formatted.
- Only clean and formatted files are committed.

### Pre-Push Hook

The pre-push hook runs automatically when you attempt to push changes. It
ensures that:

- The codebase passes all tests and builds successfully.
- Dependencies are clean and up-to-date.

### Bash Run Script (load-env-vars-and-run.sh)

The `load-env-vars-and-run.sh` script is a utility to load environment variables and execute the Go application. It is particularly useful for setting up secrets and configuration before running the application.

#### Instructions

1. Open the `load-env-vars-and-run.sh` script.
2. Replace the placeholder values enclosed in angle brackets (`<>`) with actual values. For example:

   ```bash
   KEYVAULT_NAME="my-secret-keyvault"
   export DATABASE_PASSWORD=$(az keyvault secret show --vault-name $KEYVAULT_NAME --name postgres-password --query value -o tsv)
   ```

3. Ensure the script has executable permissions:

   ```bash
   chmod +x load-env-vars-and-run.sh
   ```

4. Run the script to load environment variables and start the application:

   ```bash
   ./load-env-vars-and-run.sh
   ```

#### Key Features

- **Environment Variable Setup**: Loads secrets from Azure Key Vault and exports them as environment variables.
- **Application Execution**: Runs the Go application with the environment variables set.

#### Customization

- Modify the `KEYVAULT_NAME` and secret keys to match your project's requirements.
- Add additional environment variables or commands as needed.

## Configuration

### `.golangci.yml`

The project includes a default `.golangci.yml` configuration file for
`golangci-lint`. It enables the following formatters and linters:

- **Formatters**:
  - `gofumpt`
  - `golines`
  - `gci`
- **Linters**:
  - Default `golangci-lint` linters.
- **Issues**:
  - Automatically fixes issues where possible (`fix: true`).

You can customize this file to suit your project's needs.

## Customization

### Adding Custom Hooks

You can add additional hooks by placing them in the `.githooks` directory and
making them executable:

```bash
chmod +x .githooks/<hook-name>
```

### Modifying Existing Hooks

Edit the `pre-commit` or `pre-push` scripts in the `.githooks` directory to
customize their behavior.
