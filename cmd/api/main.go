package main

import (
	"log/slog"
)

var version = "dev"

func main() {
	name := "api"
	//nolint:sloglint // mock entry point
	slog.Info("Starting service", "name", name, "version", version)
}
