#
# Packages:
#

.PHONY: install fresh-install update upgrade publish

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

# Publish package
publish:
	pnpm publish --access public
