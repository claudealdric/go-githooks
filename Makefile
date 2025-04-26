install-lint:
	@if ! [ -x "$$(command -v golangci-lint)" ]; then \
		echo "Installing golangci-lint..."; \
		brew install golangci-lint; \
	else \
		echo "golangci-lint is already installed"; \
	fi
.PHONY: install-lint

install-hook:
	@echo "Installing pre-commit hook..."
	@cp pre-commit .git/hooks/pre-commit
	@chmod +x .git/hooks/pre-commit
	@echo "Pre-commit hook installed successfully."
.PHONY: install-hook