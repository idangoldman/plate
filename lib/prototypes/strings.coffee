import Prototypes from "#root/patterns/prototypes.js"
import capitalize from "#root/helpers/capitalize.js"
import { CASE_SEPARATORS, CASE_WHITESPACE } from "#root/helpers/regex.js"

export default class Strings extends Prototypes
  @extends "String"

  capitalize: -> capitalize @

  times: (x = 1, y = 1) ->
    Array(y)
      .fill Array(x).fill(@).join("")
      .join "\n"

  toCamelCase:    -> @toCase().first().toLowerCase() + @toCase().slice(1).map(capitalize).join('')
  toCase:         -> @replace(CASE_SEPARATORS, " $1").trim().toLowerCase().split(CASE_WHITESPACE)
  toConstantCase: -> @toCase().join("_").toUpperCase()
  toDotCase:      -> @toCase().join(".")
  toKebabCase:    -> @toCase().join("-")
  toPascalCase:   -> @toCase().map(capitalize).join("")
  toSnakeCase:    -> @toCase().join("_")
  toTitleCase:    -> @toCase().map(capitalize).join(" ")

export methods = Strings.methods()
