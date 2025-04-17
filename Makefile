# ==================================================================================== #
# VARIABLES
# ==================================================================================== #

# Applications / Services
APP_FOOCONF     := fooconf
APP_VERSION     := 0.0.1
BUILD_DIR       := ./build

# Versions
GOLANG          := golang:1.24
POSTGRES        := postgres:17.4
ALPINE          := alpine:3.21
PGADMIN         := dpage/pgadmin4:9.2.0

# ==================================================================================== #
# TOOLING
# ==================================================================================== #

## install/gotooling: Install Go tooling
.PHONY: install/gotooling
install/gotooling:
	go install honnef.co/go/tools/cmd/staticcheck@latest
	go install golang.org/x/vuln/cmd/govulncheck@latest
	go install golang.org/x/tools/cmd/goimports@latest
	go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@v2.1.2
	go install github.com/nametake/golangci-lint-langserver@latest
	go install github.com/air-verse/air@latest

## install/docker: Pull base Docker images
.PHONY: install/docker
install/docker:
	docker pull $(GOLANG) & \
	docker pull $(ALPINE) & \
	docker pull $(POSTGRES) & \
	docker pull $(PGADMIN) & \
	wait;

# ==================================================================================== #
# BUILD AND RUN LOCALLY
# ==================================================================================== #

## build: Build application binary
.PHONY: build
build:
	@mkdir -p $(BUILD_DIR)
	@go build -o $(BUILD_DIR)/$(APP_FOOCONF) ./cmd/$(APP_FOOCONF)
	@echo "Built binary: $(BUILD_DIR)/$(APP_FOOCONF)"

## run: Run built binary
.PHONY: run
run: build
	@$(BUILD_DIR)/$(APP_FOOCONF)

## dev/run: Run with live reload using air
.PHONY: dev/run
dev/run:
	@air -c .air.toml

# ==================================================================================== #
# QUALITY CONTROL
# ==================================================================================== #

## qc/vulncheck: Run vulnerability checks
.PHONY: qc/vulncheck
qc/vulncheck:
	@govulncheck ./...

## qc/staticcheck: Run static analysis
.PHONY: qc/staticcheck
qc/staticcheck:
	@staticcheck -checks=all ./...

## qc/lint: Run linter
.PHONY: qc/lint
qc/lint:
	@golangci-lint run --fix ./...

## test: Run all tests
.PHONY: test
test:
	@go test -v -race ./...

## test/cover: Run tests with coverage
.PHONY: test/cover
test/cover:
	@go test -coverprofile=coverage.out ./...
	@go tool cover -html=coverage.out -o coverage.html
	@echo "Coverage report generated: coverage.html"

# ==================================================================================== #
# GOMOD
# ==================================================================================== #

## mod/tidy: Tidy Go modules
.PHONY: mod/tidy
mod/tidy:
	@go mod tidy

## mod/verify: Verify Go modules
.PHONY: mod/verify
mod/verify:
	@go mod verify

## mod/download: Download Go modules
.PHONY: mod/download
mod/download:
	@go mod download

# ==================================================================================== #
# UTILITIES
# ==================================================================================== #

## help: Print this help message
.PHONY: help
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

# ==================================================================================== #
# ADMINISTRATION
# ==================================================================================== #

# ==================================================================================== #
# DOCKER CONTAINERS
# ==================================================================================== #

# ==================================================================================== #
# DOCKER COMPOSE
# ==================================================================================== #
