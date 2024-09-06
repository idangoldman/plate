#
# Packages:
#

.PHONY: install fresh-install update upgrade publish prune

# Install dependencies
install:
	pnpm install --frozen-lockfile

# Fresh install
fresh-install: prune
	# pnpm store prune
	pnpm prune

# Update dependencies
update:
	pnpm update

# Upgrade dependencies
upgrade:
	# pnpm upgrade --latest
	pnpm update --lockfile-only

# Publish package
publish:
	pnpm publish --access public

# Prune package
prune:
	rm -frv \
		node_modules \
		pnpm-lock.yaml \
		tmp/*
