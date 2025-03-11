import Prototypes from "#root/patterns/prototypes.js"
import capitalize from "#root/helpers/capitalize.js"
import { CASE_SEPARATORS, CASE_WHITESPACE } from "#root/helpers/regex.js"

export default class NameCasing extends Prototypes
  @extends "String", "Object"

  toCase: ->
    @replace(CASE_SEPARATORS, " $1").trim().toLowerCase().split(CASE_WHITESPACE)

  toCaseKeys: (caseType) ->
    prototypeName = "to#{capitalize caseType}Case"
    result = {}

    for own key, value of @
      newKey = key["#{prototypeName}"]()

      result[newKey] = if typeof value is "object" and value?
        value.toCaseKeys caseType
      else
        value

    result


  toCamelCase: ->
    if @.isObject()
      return @toCaseKeys "camel"

    @toCase().first().toLowerCase() + @toCase().slice(1).map(capitalize).join('')

  toConstantCase: ->
    if @.isObject()
      return @toCaseKeys "constant"

    @toCase().join("_").toUpperCase()

  toDotCase: ->
    if @.isObject()
      return @toCaseKeys "dot"

    @toCase().join(".")

  toKebabCase: ->
    if @.isObject()
      return @toCaseKeys "kebab"

    @toCase().join("-")

  toPascalCase: ->
    if @.isObject()
      return @toCaseKeys "pascal"

    @toCase().map(capitalize).join("")

  toSnakeCase: ->
    if @.isObject()
      return @toCaseKeys "snake"

    @toCase().join("_")

  toTitleCase: ->
    if @.isObject()
      return @toCaseKeys "title"

    @toCase().map(capitalize).join(" ")

export methods = NameCasing.methods()
