String::toCase = () ->
  @replace(/([A-Z])|(_)|(-)|(\.)/g, " $1").trim().toLowerCase().split(/\s+/)

String::toCamelCase = ->
  words = @.toCase()
  words[0].toLowerCase() + words.slice(1).toPascalCase()

String::toConstantCase = ->
  @.toCase().join('_').toUpperCase()

String::toDotCase = ->
  @.toCase().join('.')

String::toKebabCase = ->
  @.toCase().join('-').toLowerCase()

String::toPascalCase = ->
  @.toCase().map((word) -> word.charAt(0).toUpperCase() + word.slice(1)).join('')

String::toSnakeCase = ->
  @.toCase().join('_').toLowerCase()

String::toTitleCase = ->
  @.toCase().map((word) -> word.charAt(0).toUpperCase() + word.slice(1)).join(' ')
