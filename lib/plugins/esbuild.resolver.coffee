import { pathResolver, pathStartsWith } from "#root/transformers/resolver.js"

export default ->
  name: "resolver"
  setup: (build) ->
    build.onResolve({ filter: pathStartsWith }, async (args) ->
      resolvedPath = await pathResolver(args.path)
      { path: resolvedPath, namespace: "file" }
    )
