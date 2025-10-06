import { readFile } from "node:fs/promises"

import YAML from "yaml"
import * as esbuild from "esbuild"
import coffeeScriptPlugin from "esbuild-coffeescript"

try
  [transpileKey] = process.argv.slice(2)
  transpileFileContents = await readFile("#{process.env.PLATE_PKG_PATH}/configs/transpile.yml", "utf8")
  transpileJsObject = YAML.parse(transpileFileContents)
  transpileConfig = transpileJsObject[transpileKey]

catch error
  console.error "Error reading or parsing transpile configuration: #{error.message}"
  process.exit 1

esbuild
  .build
    absWorkingDir: process.env.PLATE_PKG_PATH
    bundle: false
    charset: 'utf8'
    entryPoints: transpileConfig.entrypoints
    format: transpileConfig.format
    minify: true
    outdir: transpileConfig.outdir
    platform: transpileConfig.platform
    plugins: [coffeeScriptPlugin()]
    sourcemap: true
    target: transpileConfig.targets

  .catch (error) ->
    console.error "Error during transpilation: #{error.message}"
    process.exit 1
