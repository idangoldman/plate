.PHONY: help
.DEFAULT_GOAL := help

PLATE_ENV ?= development
PLATE_PKG_PATH ?= ./
PLATE_PRJ_PATH ?= $(PLATE_PKG_PATH)
PLATE_BIN_PATH ?= $(PLATE_PKG_PATH)/node_modules/.bin
PLATE_CONF_PATH ?= $(PLATE_PKG_PATH)/configs

# Help command
help:
	@echo "PLATE CLI"
	@echo "--------------"
	@echo "Usage:"
	@echo "  plate [pkg] <command> [arguments]"
	@echo ""
	@echo "Commands:"
	@echo ""
	@awk ' \
		BEGIN { section = "" } \
		/^[#] [A-Z][A-Za-z0-9 ]+:/ { section = substr($$0, 3); printf "\n  %s\n\n", section } \
		/^[#].*/ { last_comment = substr($$0, 3) } \
		/^[a-z_-]+:/ { target = $$1; sub(/:/, "", target); if (last_comment) { printf "  %-25s %s\n", target, last_comment; last_comment = "" } } \
		' $(MAKEFILE_LIST)

# Used in case of need running a command with-in plate package folder
pkg:
	@echo $(PLATE_PKG_PATH)

# Load makefiles
include $(PLATE_PKG_PATH)/makefiles/*.mk
