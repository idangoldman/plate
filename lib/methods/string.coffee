String::toCase = () ->
  @replace(/([A-Z])|(_)|(-)|(\.)/g, " $1").trim().toLowerCase().split(/\s+/)

String::toCamelCase = ->
  words = @.toCase()
  words.first().toLowerCase() + words.slice(1).toPascalCase()

String::toConstantCase = ->
  @.toCase().join('_')

String::toDotCase = ->
  @.toCase().join('.')

String::toKebabCase = ->
  @.toCase().join('-')

String::toPascalCase = ->
  @.toCase().map((word) -> word.toCapitalize()).join('')

String::toSnakeCase = ->
  @.toCase().join('_')

String::toTitleCase = ->
  @.toCase().map((word) -> word.toCapitalize()).join(' ')

String::toCapitalize = ->
  @.charAt(0).toUpperCase() + @.slice(1)
