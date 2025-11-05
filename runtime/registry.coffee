import { register } from "node:module"

# Importing global variables
import "#{PLATE_PKG_PATH}/runtime/boot/globals.coffee"

# Registering loaders
# https://www.npmjs.com/package/import-glob
register "#{PLATE_PKG_PATH}/runtime/loaders/resolver.coffee", import.meta.url
register "#{PLATE_PKG_PATH}/runtime/loaders/yaml.coffee", import.meta.url
register "#{PLATE_PKG_PATH}/runtime/loaders/coffeescript.coffee", import.meta.url

# Setting up environment with variables and methods
do ->
  await import("#{PLATE_PKG_PATH}/runtime/boot/environment.coffee")

  methods = await import("#{PLATE_PKG_PATH}/library/prototypes/defaults.coffee")
  methods.initialize()
