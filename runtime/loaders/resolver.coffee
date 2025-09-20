import pathResolver from "#runtime/transformers/resolver"

export resolve = (specifier, context, nextResolve) ->
  resolvedPath = await pathResolver(specifier)
  nextResolve resolvedPath, context, nextResolve
