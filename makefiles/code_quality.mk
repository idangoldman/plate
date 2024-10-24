#
# Code Quality:
#

.PHONY: format format-fix lint lint-fix

# Support formatting js, cjs, mjs, coffee, css, scss files
format:
	@$(PLATE_BIN_PATH)/prettier --check --config $(PLATE_CONF_PATH)/prettierrc.yml ./**/*.{js,cjs,mjs,coffee,css,scss}

# Automatically fix formatting issues in supported files
format-fix:
	@$(PLATE_BIN_PATH)/prettier --write --config $(PLATE_CONF_PATH)/prettierrc.yml ./**/*.{js,cjs,mjs,coffee,css,scss}

# Support linting js, cjs, mjs, coffee files
lint:
	# @$(PLATE_BIN_PATH)/coffeelint --file $(PLATE_CONF_PATH)/coffeelint.json bin/locals.coffee
	@$(PLATE_BIN_PATH)/eslint --config $(PLATE_CONF_PATH)/eslint.config.js .

# Automatically fix linting issues in supported files
lint-fix:
	@$(PLATE_BIN_PATH)/eslint --fix --config $(PLATE_CONF_PATH)/eslint.config.js .
