.PHONY: help
.DEFAULT_GOAL := help

# Load environment variables
# include .env

# Define environment variables
SHELL ?= /usr/bin/env fish
PLATE_ENV ?= development
PLATE_PKG_PATH ?= $(shell pwd)
PLATE_PRJ_PATH ?= $(PLATE_PKG_PATH)
PLATE_CONF_PATH ?= $(PLATE_PKG_PATH)/configs
PLATE_BIN_PATH ?= $(PLATE_PKG_PATH)/node_modules/.bin

# Help command
help:
	@echo "PLATE Makefile"
	@echo "--------------"
	@echo "Usage:"
	@echo "  make <target> [ENV_VAR=<value>]"
	@echo ""
	@echo "Environment Variables:"
	@awk ' \
		/^[A-Z][A-Z_]+/ { var = $$1; printf "  %-25s %s\n", var, "" } \
	' $(MAKEFILE_LIST)
	@echo ""
	@echo "Targets:"
	@echo ""
	@awk ' \
		BEGIN { section = "" } \
		/^[#] [A-Z][A-Za-z0-9 ]+:/ { section = substr($$0, 3); printf "\n  %s\n\n", section } \
		/^[#].*/ { last_comment = substr($$0, 3) } \
		/^[a-z_-]+:/ { target = $$1; sub(/:/, "", target); if (last_comment) { printf "  %-25s %s\n", target, last_comment; last_comment = "" } } \
		' $(MAKEFILE_LIST)

# Load additional makefiles
include ./makefiles/*.mk
