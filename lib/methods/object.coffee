import capitalize from "#root/helpers/capitalize.js"

Object::toCaseKeys = (caseType) ->
  prototypeName = "to#{capitalize caseType}Case"
  result = {}

  for own key, value of @
    newKey = key["#{prototypeName}"]()

    result[newKey] = if typeof value is "object" and value?
      value.toCaseKeys caseType
    else
      value

  result

Object::toCamelCaseKeys = ->
  @toCaseKeys "camel"

Object::toConstantCaseKeys = ->
  @toCaseKeys "constant"

Object::toKebabCaseKeys = ->
  @toCaseKeys "kebab"

Object::toPascalCaseKeys = ->
  @toCaseKeys "pascal"

Object::toSnakeCaseKeys = ->
  @toCaseKeys "snake"
