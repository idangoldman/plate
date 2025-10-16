import esbuild from "esbuild"

import yamlTransformer from "#runtime/transformers/yaml.coffee"
import coffeescriptESBuildLoader "#runtime/loaders/esbuild/coffeescript.coffee"

try
  [transpileKey] = process.argv.slice(2)
  transpileJsObject = yamlTransformer(path.join process.env.PLATE_PKG_PATH, "configs", "transpile.yml")
  transpileConfig = transpileJsObject[transpileKey]

catch error
  console.error "Error reading or parsing transpile configuration: #{error.message}"
  process.exit 1

esbuild
  .build({
    transpileConfig...
    absWorkingDir: path.resolve process.env.PLATE_PKG_PATH
    plugins: [
      coffeescriptESBuildLoader
    ]
  })
  .catch (error) ->
    console.error "Error during transpilation: #{error.message}"
    process.exit 1
