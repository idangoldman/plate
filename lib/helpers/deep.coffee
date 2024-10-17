import merge from "lodash/merge.js"

# Copy of https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/freeze
export deepFreeze = (object) ->
  propNames = Reflect.ownKeys object

  for name in propNames
    value = object[name]

    if (value and typeof value is "object") or typeof value is "function"
      deepMergeFreeze value

  Object.freeze object

export deepMergeFreeze = (...objects) ->
  deepFreeze merge({}, ...objects)
