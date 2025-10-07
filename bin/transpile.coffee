import { readFile } from "node:fs/promises"
import path from "node:path"

import coffeescript from "coffeescript"
import esbuild from "esbuild"
import YAML from "yaml"

try
  [transpileKey] = process.argv.slice(2)
  transpileFileContents = await readFile("#{process.env.PLATE_PKG_PATH}/configs/transpile.yml", "utf8")
  transpileJsObject = YAML.parse(transpileFileContents)
  transpileConfig = transpileJsObject[transpileKey]

catch error
  console.error "Error reading or parsing transpile configuration: #{error.message}"
  process.exit 1

transpileESBuildPlugin =
  name: "transpile-esbuild-plugin"
  setup: (build) ->
    build.onLoad { filter: /\.coffee$/ }, (args) ->
      source = await readFile args.path, "utf8"

      # Rewrite import paths inside CoffeeScript files
      try
        modifiedSource = source.replace /import\s+((?:[\w*\s{},]*)\s+from\s+)?['"](#(library|runtime|tests)\/[^'"]+?)(\.coffee|\.yaml|\.yml)?['"]/g, (match, importPart, importPath, folder, extension) ->
          if folder?
            newPath = importPath.replace folder, "root/#{folder}"

          if extension?
            newPath += '.js'

          "import #{importPart or ''}'#{newPath}'"

      catch error
        return {
          errors: [{
            text: error.message
            location:
              file: args.path
          }]
        }

      # CoffeeScript transpilation
      try
        contents = coffeescript.compile(modifiedSource, {
          bare: true
          filename: path.relative process.cwd(), args.path
          header: false
          inlineMap: true
          sourceMap: false
        })

        return { contents}

      catch error
        return {
          errors: [{
            text: error.message
            location:
              file: error.filename
              line: error.location?.first_line
              column: error.location?.first_column
              length: Math.max(1, (error.location?.last_column || 0) - (error.location?.first_column || 0))
              lineText: error.code
          }]
        }

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
    plugins: [
      transpileESBuildPlugin
    ]
    sourcemap: true
    target: transpileConfig.targets

  .catch (error) ->
    console.error "Error during transpilation: #{error.message}"
    process.exit 1
