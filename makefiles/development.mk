#
# Development:
#

.PHONY: clean build watch build-test test run

# Clean the project
clean:
	rm -rfv \
		$(PLATE_PRJ_PATH)/src \
		$(PLATE_PRJ_PATH)/tests/steps/*.js

# Build the project
build: clean
	$(PLATE_BIN_PATH)/coffee \
		--bare \
		--compile \
		--no-header \
		--output $(PLATE_PRJ_PATH)/src \
		$(PLATE_PRJ_PATH)/lib

# Watch the project
watch: clean
	$(PLATE_BIN_PATH)/coffee \
		--bare \
		--compile \
		--inline-map \
		--no-header \
		--watch \
		--output $(PLATE_PRJ_PATH)/src \
		$(PLATE_PRJ_PATH)/lib

# Build the test project
build-test: build
	$(PLATE_BIN_PATH)/coffee \
		--bare \
		--compile \
		--no-header \
		$(PLATE_PRJ_PATH)/tests

# Test the project
test: build-test
	$(PLATE_BIN_PATH)/cucumber-js --config="$(PLATE_CONF_PATH)/cucumber.yml"

# Run the project via Node.js
run:
	node \
		--trace-warnings \
		--trace-deprecation \
		--trace-uncaught \
		--import="$(PLATE_PKG_PATH)/src/registry.js" \
		$(PLATE_CLI_ARGS)
