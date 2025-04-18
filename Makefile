# ==================================================================================== #
# VARIABLES
# ==================================================================================== #

# Services
APP_API    := api
APP_AUTH   := auth

VERSION    := 0.0.1
BUILD_DIR  := ./build

IMAGE_BASE := yndarv
IMAGE_API  := $(IMAGE_BASE)/$(APP_API):$(VERSION)
IMAGE_AUTH := $(IMAGE_BASE)/$(APP_AUTH):$(VERSION)

# ==================================================================================== #
# Local build
# ==================================================================================== #

## api/build: Builds api binary to build/api
.PHONY: api/build
api/build:
	@mkdir -p $(BUILD_DIR)
	@go build -o $(BUILD_DIR)/$(APP_API) \
		-ldflags "-X main.version=$(VERSION)" \
		./cmd/$(APP_API)
	@echo "Built binary: $(BUILD_DIR)/$(APP_API) v$(VERSION)"

## api/run: Run built api binary
.PHONY: api/run
api/run: build
	@$(BUILD_DIR)/$(APP_API)

## api/air: Run api with live reload using air
.PHONY: api/air
api/air:
	@air -c .air.toml -build.cmd="go build -o $(BUILD_DIR) ./cmd/$(APP_API)"

## api/debug: Debug binary with delve
.PHONY: api/debug
api/debug:
	@dlv debug ./cmd/$(APP_API)

## api/debug-headless: Debug binary with delve in headless mode
.PHONY: api/debug-headless
api/debug-headless:
	@dlv debug --headless \
		--listen :1337 \
		--api-version 2 \
		./cmd/$(APP_API)

## api/debug-headless-connect: Attach to delve in headless mode
.PHONY: api/debug-headless-connect
api/debug-headless-connect:
	@dlv connect :1337

# ==================================================================================== #
# QUALITY CONTROL
# ==================================================================================== #

## vulncheck: Run vulnerability checks
.PHONY: vulncheck
vulncheck:
	@govulncheck ./...

## staticcheck: Run static analysis
.PHONY: staticcheck
staticcheck:
	@staticcheck -checks=all ./...

## lint: Run linter
.PHONY: lint
lint:
	@golangci-lint run ./...

## lint-fix: Run linter and fix issues if supported
.PHONY: lint-fix
lint-fix:
	@golangci-lint run --fix ./...

## test: Run all tests
.PHONY: test
test:
	@go test -v -race ./...

## test-cover: Run tests with coverage
.PHONY: test-cover
test-cover:
	@go test -coverprofile=coverage.out ./...
	@go tool cover -html=coverage.out -o coverage.html
	@echo "Coverage report generated: coverage.html"

# ==================================================================================== #
# GOMOD
# ==================================================================================== #

## tidy: Tidy Go modules
.PHONY: tidy
tidy:
	@go mod tidy

## verify: Verify Go modules
.PHONY: verify
verify:
	@go mod verify

## download: Download Go modules
.PHONY: download
download:
	@go mod download

## vendor: Move deps to vendor/
.PHONY: vendor
vendor:
	@go mod vendor

# ==================================================================================== #
# UTILITIES
# ==================================================================================== #

## help: Print this help message
.PHONY: help
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

## tooling: installs dev tooling
.PHONY: tooling
tooling:
	go install honnef.co/go/tools/cmd/staticcheck@latest
	go install golang.org/x/vuln/cmd/govulncheck@latest
	go install golang.org/x/tools/cmd/goimports@latest
	go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@v2.1.2
	go install github.com/nametake/golangci-lint-langserver@latest
	go install github.com/air-verse/air@latest
	go install github.com/go-delve/delve/cmd/dlv@latest

# ==================================================================================== #
# Docker Images
# ==================================================================================== #

## api/docker-build: Builds image for api
.PHONY: api/docker-build
api/docker-build:
	@docker build \
		-f ./docker/api.Dockerfile \
		-t $(IMAGE_API) \
		--build-arg BUILD_VERSION=$(VERSION) \
		--build-arg BUILD_DATE=$$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
		--build-arg BUILD_COMMIT=$$(git rev-parse HEAD) \
		.

# ==================================================================================== #
# Docker Compose
# ==================================================================================== #

## compose-up: up
.PHONY: compose-up
compose-up:
	@COMPOSE_BAKE=true docker compose up -d

## compose-down: down
.PHONY: compose-down
compose-down:
	@COMPOSE_BAKE=true docker compose down

## compose-build: build
.PHONY: compose-build
compose-build:
	@COMPOSE_BAKE=true docker compose build
