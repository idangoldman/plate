import capitalize from "#root/helpers/capitalize.js"
import PrototypeBase from "#root/methods/prototypes/base.js"
import { CASE_SEPARATORS, CASE_WHITESPACE } from "#root/helpers/regex.js"

export default class PrototypeString extends PrototypeBase
  @extends "String"

  toCamelCase:    -> @toCase().first().toLowerCase() + @toCase().from(1).map(capitalize).join('')
  toCase:         -> @replace(CASE_SEPARATORS, " $1").trim().toLowerCase().split(CASE_WHITESPACE)
  toConstantCase: -> @toCase().join("_").toUpperCase()
  toDotCase:      -> @toCase().join(".")
  toKebabCase:    -> @toCase().join("-")
  toPascalCase:   -> @toCase().map(capitalize).join("")
  toSnakeCase:    -> @toCase().join("_")
  toTitleCase:    -> @toCase().map(capitalize).join(" ")

export methods = PrototypeString.methods()
