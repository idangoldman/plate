#
# Packages:
#

.PHONY: install fresh-install update upgrade publish prune

# Install dependencies
install:
	@pnpm install --frozen-lockfile
	@pnpm link .

# Fresh install
fresh-install: prune
	# @pnpm store prune
	@pnpm prune
	@pnpm link .

# Update dependencies
update:
	# @pnpm upgrade --latest
	# @pnpm update --lockfile-only
	@pnpm update

# Upgrade pnpm and node
upgrade:
	# @fnm install --latest
	@corepack up
	@pnpm add -g pnpm

# Publish package
publish:
	@pnpm publish --access public

# Prune package
prune:
	@rm -frv \
		node_modules \
		pnpm-lock.yaml \
		tmp/*
