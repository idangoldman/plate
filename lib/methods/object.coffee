Object::toCaseKeys = (caseName) ->
  caseMethodName = "to#{caseName.toTitleCase()}Case"

  for key, value of @
    newKey = key[caseMethodName]()

    if typeof value is "object"
      value = value.toCaseKeys(caseName)

    @[newKey] = value

Object::toCamelCase = ->
  @.toCaseKeys "camel"

Object::toConstantCase = ->
  @.toCaseKeys "constant"

Object::toKebabCase = ->
  @.toCaseKeys "kebab"

Object::toPascalCase = ->
  @.toCaseKeys "pascal"

Object::toSnakeCase = ->
  @.toCaseKeys "snake"
