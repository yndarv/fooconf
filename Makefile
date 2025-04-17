# ==================================================================================== #
# VARIABLES
# ==================================================================================== #

# Applications / Services
APP_FOOCONF     := fooconf
APP_VERSION     := 0.0.1

# Versions
GOLANG          := golang:1.24
POSTGRES        := postgres:17.4
ALPINE          := alpine:3.21
PGADMIN         := dpage/pgadmin4:9.2.0

# ==================================================================================== #
# TOOLING
# ==================================================================================== #

.PHONY: install/gotooling
install/gotooling:
	go install honnef.co/go/tools/cmd/staticcheck@latest
	go install golang.org/x/vuln/cmd/govulncheck@latest
	go install golang.org/x/tools/cmd/goimports@latest
	go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
	go install github.com/nametake/golangci-lint-langserver@latest

	# go install golang.org/x/tools/gopls@latest
	# go install github.com/go-delve/delve/cmd/dlv@latest
	# go install github.com/segmentio/golines@latest


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

# ==================================================================================== #
# ADMINISTRATION
# ==================================================================================== #

# ==================================================================================== #
# QUALITY CONTROL
# ==================================================================================== #

# ==================================================================================== #
# GOMOD
# ==================================================================================== #

# ==================================================================================== #
# DOCKER CONTAINERS
# ==================================================================================== #

# ==================================================================================== #
# DOCKER COMPOSE
# ==================================================================================== #
