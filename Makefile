SERVICE_NAME := $(shell go list -m | sed 's/.*\///' | sed 's/-go$$//')

.PHONY: init
init:
	git submodule update --init --recursive
	bash ./.githooks/install.sh

.PHONY: run
run:
	if [ -f ./load-env-vars-and-run.sh ]; then \
		./load-env-vars-and-run.sh; \
	else \
		APP_CONFIG_DIR=$$PWD go run ./cmd/$(SERVICE_NAME)/main.go; \
	fi

.PHONY: build
build:
	go build -o $(SERVICE_NAME) ./cmd/$(SERVICE_NAME)/main.go

.PHONY: test
test:
	go test ./...
	go test -race ./...

.PHONY: fmt
fmt:
	golangci-lint fmt

.PHONY: lint
lint:
	golangci-lint run

.PHONY: vendor
vendor:
	go mod tidy
	go mod vendor

.PHONY: check
check:
	go vet ./...
	go build -o /dev/null ./...
	go test ./... -v
	go test -race ./...
	golangci-lint run
