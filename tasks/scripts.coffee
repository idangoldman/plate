import esbuild from "esbuild"
import glob from "fast-glob"

import coffeePlugin from "@/imports/plugins/esbuild.coffee.mjs"
import yamlPlugin from "@/imports/plugins/esbuild.yaml.mjs"
import resolverPlugin from "@/imports/plugins/esbuild.resolver.mjs"

export default Scripts = ->
  paths = PLATE_ENV.globs.scripts
  entryPoints = glob.sync paths.src

  return esbuild.build({
      entryPoints
      bundle: true
      outdir: paths.dest
      platform: 'browser'
      format: 'esm'
      plugins: [
        resolverPlugin(),
        coffeePlugin(),
        yamlPlugin()
      ]
    }).catch (error) ->
      console.error error
      process.exit 1
