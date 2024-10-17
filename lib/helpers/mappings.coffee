import { SNAKE_CASE, REMOVABLE_CHARACTERS } from "#root/helpers/regex.js"

snakeToCamel = (str) ->
  str
    .replace SNAKE_CASE, (match, group1) -> group1.toUpperCase()
    .replace REMOVABLE_CHARACTERS, ""

export fromSnakeToCamel = (obj) ->
  if Array.isArray obj
    obj.map fromSnakeToCamel
  else if obj and typeof obj is "object"
    Object.entries(obj).reduce (newObject, [key, value]) ->
      newObject[snakeToCamel(key)] = fromSnakeToCamel value
      newObject
    , {}
  else
    obj
