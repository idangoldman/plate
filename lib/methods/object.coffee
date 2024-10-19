Object::toCaseKeys = (caseName) ->
  caseMethodName = "to#{caseName.toTitleCase()}Case"

  for key, value of @
    newKey = key[caseMethodName]()

    if typeof value is "object"
      value = value.toCaseKeys(caseName)

    @[newKey] = value

  @

Object::toCamelCaseKeys = ->
  @.toCaseKeys "camel"

Object::toConstantCaseKeys = ->
  @.toCaseKeys "constant"

Object::toKebabCaseKeys = ->
  @.toCaseKeys "kebab"

Object::toPascalCaseKeys = ->
  @.toCaseKeys "pascal"

Object::toSnakeCaseKeys = ->
  @.toCaseKeys "snake"
