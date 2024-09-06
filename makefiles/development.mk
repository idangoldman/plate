#
# Development:
#

.PHONY: build watch

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
