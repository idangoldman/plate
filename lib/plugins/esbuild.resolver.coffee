import { STARTS_WITH_BASE_PATH } from "#root/helpers/regex.js"
import pathResolver from "#root/transformers/resolver.js"

export default ->
  name: "resolver"
  setup: (build) ->
    build.onResolve({ filter: STARTS_WITH_BASE_PATH }, async (args) ->
      resolvedPath = await pathResolver(args.path)
      { path: resolvedPath, namespace: "file" }
    )
