import merge from "lodash/merge.js"

# Copy of https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/freeze
export deepFreeze = (object) ->
  propNames = Reflect.ownKeys object

  for name in propNames
    value = object[name]

    if (value and typeof value is "object") or typeof value is "function"
      deepFreezeMerge value

  Object.freeze object

export deepFreezeMerge = (...objects) ->
  deepFreeze merge({}, ...objects)

export importEnvironmentFile = async (filePath) ->
  environtmentFile = undefined

  try
    environtmentFile = (await import(filePath)).default
  catch e
    console.warn "No environment file found at #{filePath}"
  finally
    environtmentFile

SNAKE_CASE_REGEX = new RegExp("[_]([a-z])", "gi")
REMOVABLE_CHARACTERS = new RegExp("_+", "gi")

snakeToCamel = (str) ->
  str
    .replace SNAKE_CASE_REGEX, (match, group1) -> group1.toUpperCase()
    .replace REMOVABLE_CHARACTERS, ""

export transformKeysFromSnakeToCamel = (obj) ->
  if Array.isArray obj
    obj.map transformKeysFromSnakeToCamel
  else if obj and typeof obj is "object"
    Object.entries(obj).reduce (newObject, [key, value]) ->
      newObject[snakeToCamel(key)] = transformKeysFromSnakeToCamel value
      newObject
    , {}
  else
    obj
