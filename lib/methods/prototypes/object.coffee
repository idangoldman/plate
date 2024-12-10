import capitalize from "#root/helpers/capitalize.js"
import PrototypeBase from "#root/methods/prototypes/base.js"

export default class PrototypeObject extends PrototypeBase
  @extends "Object"

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

  toCamelCaseKeys:    -> @toCaseKeys "camel"
  toConstantCaseKeys: -> @toCaseKeys "constant"
  toKebabCaseKeys:    -> @toCaseKeys "kebab"
  toPascalCaseKeys:   -> @toCaseKeys "pascal"
  toSnakeCaseKeys:    -> @toCaseKeys "snake"

  # keys: -> if Object.keys? then Object.keys @ else []

export methods = PrototypeObject.methods()
