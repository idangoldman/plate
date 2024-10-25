import capitalize from "#root/helpers/capitalize.js"
import { CASE_SEPARATORS, CASE_WHITESPACE } from "#root/helpers/regex.js"

String::toCase = () ->
  @replace CASE_SEPARATORS, " $1"
    .trim()
    .toLowerCase()
    .split CASE_WHITESPACE

String::toCamelCase = ->
  words = @toCase()
  words.first().toLowerCase() + words.slice(1).map(capitalize).join('')

String::toConstantCase = ->
  @toCase()
    .join "_"
    .toUpperCase()

String::toDotCase = ->
  @toCase()
    .join "."

String::toKebabCase = ->
  @toCase()
    .join "-"

String::toPascalCase = ->
  @toCase()
    .map capitalize
    .join ""

String::toSnakeCase = ->
  @toCase()
    .join "_"

String::toTitleCase = ->
  @toCase()
    .map capitalize
    .join " "
