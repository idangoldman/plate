#
# Maintenance:
#

.PHONY: install update upgrade fresh-install clean

# Install dependencies
install:
	pnpm install --frozen-lockfile

# Fresh install
fresh-install:
	rm -rvf node_modules pnpm-lock.yaml
	# pnpm store prune
	pnpm prune

# Update dependencies
update:
	pnpm update

# Upgrade dependencies
upgrade:
	pnpm upgrade

# Clean the project
clean:
	rm -rfv $(PLATE_PKG_PATH)/src
	mkdir -p $(PLATE_PKG_PATH)/src
