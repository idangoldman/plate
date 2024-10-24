import { register } from "node:module"

# Importing global variables
import "./globals.js"

# Registering loaders
register "#{PLATE_PKG_PATH}/src/loaders/resolver.js", import.meta.url
register "#{PLATE_PKG_PATH}/src/loaders/yaml.js", import.meta.url
register "#{PLATE_PKG_PATH}/src/loaders/coffee.js", import.meta.url

# Setting up environment with variables and methods
do ->
  await import("#{PLATE_PKG_PATH}/src/environment.js")
  await import("#{PLATE_PKG_PATH}/src/methods/defaults.js")
