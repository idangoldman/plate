import esbuild from "esbuild"

import coffeePlugin from "#runtime/esbuild/coffeescript"
import resolverPlugin from "#runtime/esbuild/resolver"
import yamlPlugin from "#runtime/esbuild/yaml"

export createBuildConfig = (options = {}) -> {
    bundle: false
    conditions: if options.development then ["development"] else ["production"]
    entryPoints: ["library/**/*.coffee", "runtime/**/*.coffee"]
    format: "esm"
    minify: true
    outdir: "dist"
    platform: "browser"
    resolveExtensions: [".coffee", "", ".yml", ".yaml"]
    sourcemap: true
    target: ["es2020"]
    watch: false

    plugins: [
      resolverPlugin()
      coffeePlugin()
      yamlPlugin()
    ]
  }
