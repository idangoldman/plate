import { readFile } from "node:fs/promises"
import YAML from "yaml"
import * as esbuild from "esbuild"
import coffeeScriptPlugin from "esbuild-coffeescript"

try
  [environmentFilePath, configKey] = process.argv.slice(2)

  if not environmentFilePath?
    throw new Error "Missing environment file path argument."

  if not configKey?
    throw new Error "Missing config key argument."

catch error
  console.error "Error processing arguments: #{error.message}"
  process.exit 1

try
  fileContent = await readFile(environmentFilePath, "utf8")
  parsedYAML = YAML.parse(fileContent)
  buildConfig = parsedYAML[configKey]

catch error
  console.error "Error reading or parsing environment file '#{environmentFilePath}': #{error.message}"
  process.exit 1

esbuild
  .build
    bundle: false
    charset: 'utf8'
    entryPoints: buildConfig.entrypoints
    format: "esm"
    minify: true
    outdir: buildConfig.outdir
    platform: "browser"
    plugins: [coffeeScriptPlugin()]
    sourcemap: true
    target: ["es2020"]

  .catch (error) ->
    console.error "Error during transpilation: #{error.message}"
    process.exit 1
