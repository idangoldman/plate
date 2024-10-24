import capitalize from "#root/helpers/capitalize.js"

String::toCase = () ->
  @replace(/([A-Z])|[_\-\.]/g, " $1").trim().toLowerCase().split(/\s+/)

String::toCamelCase = ->
  words = @toCase()
  words.first().toLowerCase() + words.slice(1).map(capitalize).join('')

String::toConstantCase = ->
  @toCase().join('_').toUpperCase()

String::toDotCase = ->
  @toCase().join('.')

String::toKebabCase = ->
  @toCase().join('-')

String::toPascalCase = ->
  @toCase().map(capitalize).join('')

String::toSnakeCase = ->
  @toCase().join('_')

String::toTitleCase = ->
  @toCase().map(capitalize).join(' ')
