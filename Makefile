.PHONY: help format format-fix lint lint-fix publish
.DEFAULT_GOAL := help

# Makefile help
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Available targets:"
	@awk ' \
		/^[#].*/ { last_comment = substr($$0, 3) } \
		/^[a-z\-\_]+:/ { target = $$1; sub(/:/, "", target); if (last_comment) { printf "  %-15s %s\n", target, last_comment; last_comment = "" } } \
		' $(MAKEFILE_LIST)


# Define targets for checking code
format:
	prettier --check --config configs/prettierrc.yml ./**/*.{js,cjs,mjs,coffee,css,scss}

# Define targets for formatting code
format_fix:
	prettier --write --config configs/prettierrc.yml ./**/*.{js,cjs,mjs,coffee,css,scss}

# Define targets for linting code
lint:
	eslint --config configs/eslint.config.js .

# Define targets for fixing linting issues
lint_fix:
	eslint --fix --config configs/eslint.config.js .

coffeelint:
	# coffeelint --file configs/coffeelint.json .
	coffeelint --file configs/coffeelint.json bin/locals.coffee

# Define target for publishing
publish:
	pnpm publish --access public
