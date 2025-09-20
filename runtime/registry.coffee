import { register } from "node:module"

# Importing global variables
import "./bootstrap/globals"

# Registering loaders
# https://www.npmjs.com/package/import-glob
register "#{PLATE_PKG_PATH}/runtime/loaders/resolver", import.meta.url
register "#{PLATE_PKG_PATH}/runtime/loaders/yaml", import.meta.url
register "#{PLATE_PKG_PATH}/runtime/loaders/coffeescript", import.meta.url

# Setting up environment with variables and methods
do ->
  await import("#{PLATE_PKG_PATH}/runtime/bootstrap/environment")

  methods = await import("#{PLATE_PKG_PATH}/library/prototypes/defaults")
  methods.initialize()
