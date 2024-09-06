#
# Development:
#

.PHONY: clean build watch build-test test

# Clean the project
clean:
	rm -rfv \
		$(PLATE_PKG_PATH)/src \
		$(PLATE_PKG_PATH)/tests/steps/*.js

# Build the project
build: clean
	$(PLATE_BIN_PATH)/coffee \
		--bare \
		--compile \
		--no-header \
		--output $(PLATE_PKG_PATH)/src \
		$(PLATE_PKG_PATH)/lib

# Watch the project
watch: clean
	$(PLATE_BIN_PATH)/coffee \
		--bare \
		--compile \
		--inline-map \
		--no-header \
		--watch \
		--output $(PLATE_PKG_PATH)/src \
		$(PLATE_PKG_PATH)/lib

# Build the test project
build-test: build
	$(PLATE_BIN_PATH)/coffee \
		--bare \
		--compile \
		--no-header \
		$(PLATE_PKG_PATH)/tests/steps

# Test the project
test: build-test
	$(PLATE_BIN_PATH)/cucumber-js --config="configs/cucumber.yml"
