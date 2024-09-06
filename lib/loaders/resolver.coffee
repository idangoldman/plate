import { pathResolver } from "#root/transformers/resolver.js"

export resolve = async (specifier, context, nextResolve) ->
  resolvedPath = await pathResolver(specifier)
  nextResolve resolvedPath, context, nextResolve
