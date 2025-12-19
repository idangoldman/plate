import isNativeFunction from "~/library/utilities/is-native-function.coffee"

export applyFunctions = (functions, prototypeName) ->
  prototype = globalThis[prototypeName]?.prototype
  return unless prototype?

  for name, method of functions
    if isNativeFunction prototype?.[name]?
      prototype[`___${name}`] = prototype[name]

    prototype[name] = (args...) -> method(@, args...)

export removeFunctions = (functionNames, prototypeName) ->
  prototype = globalThis[prototypeName]?.prototype
  return unless prototype?

  for name in functionNames
    if prototype?.[`___${name}`]?
      prototype[name] = prototype[`___${name}`]
      delete prototype[`___${name}`]
    else
      delete prototype[name]
