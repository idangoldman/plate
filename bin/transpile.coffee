{ readFile } = require "node:fs/promises"
esbuild = require "esbuild"
path = require "node:path"
YAML = require "yaml"

try
  [transpileKey] = process.argv.slice(2)
  transpileFilePath = path.join process.env.PLATE_PKG_PATH, "configs", "transpile.yml"
  transpileFileContents = await readFile(transpileFilePath, "utf8")
  transpileJsObject = YAML.parse(transpileFileContents, { merge: true })
  transpileConfig = transpileJsObject[transpileKey]
  console.log transpileJsObject
  process.exit 0

catch error
  console.error "Error reading or parsing transpile configuration: #{error.message}"
  process.exit 1

esbuild
  .build({
    transpileConfig...
    absWorkingDir: path.resolve process.env.PLATE_PKG_PATH
    plugins: [
      require "#runtime/loaders/esbuild/coffeescript.coffee"
    ]
  })
  .catch (error) ->
    console.error "Error during transpilation: #{error.message}"
    process.exit 1
