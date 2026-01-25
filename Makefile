# Makefile for OpenCode

# Variables
BUN := $(shell which bun 2>/dev/null || echo ~/.bun/bin/bun)
PACKAGE_DIR := packages/opencode
BUILD_SCRIPT := script/build.ts
INSTALL_DIR := $(HOME)/.bun/bin
BINARY_NAME := opencode-dev

.PHONY: all build release clean help install dev

# Default target: Build for the current platform (fast)
all: clean build

# Build for the current platform only
build:
	@echo "Building OpenCode for current platform..."
	cd $(PACKAGE_DIR) && $(BUN) $(BUILD_SCRIPT) --single

# Build for all supported platforms (Release mode)
release:
	@echo "Building OpenCode for all platforms..."
	cd $(PACKAGE_DIR) && $(BUN) $(BUILD_SCRIPT)

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	rm -rf $(PACKAGE_DIR)/dist

# Install the binary to the user path
install:
	@echo "Installing $(BINARY_NAME) to $(INSTALL_DIR)..."
	@mkdir -p $(INSTALL_DIR)
	@# Find the binary in the dist directory (handling the dynamic platform name)
	@cp $$(find $(PACKAGE_DIR)/dist -type f -name opencode | head -n 1) $(INSTALL_DIR)/$(BINARY_NAME)
	@echo "Installed $(BINARY_NAME) to $(INSTALL_DIR)"

# Build and install
dev: clean build install

# Show help
help:
	@echo "OpenCode Makefile"
	@echo ""
	@echo "Usage:"
	@echo "  make          Build for the current platform (alias for 'make build')"
	@echo "  make build    Build for the current platform only (--single)"
	@echo "  make dev      Build and install as '$(BINARY_NAME)' to $(INSTALL_DIR)"
	@echo "  make release  Build for all supported platforms (Linux, macOS, Windows)"
	@echo "  make clean    Remove dist directory"
