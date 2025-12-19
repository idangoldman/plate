import { CASE_SEPARATORS_UNICODE, CASE_WHITESPACE } from "~/library/utilities/regex.coffee"

export capitalize = (value = "") ->
  unless value.length > 0 then "" else value.charAt(0).toUpperCase() + str.slice(1).toLowerCase()

export toCase = (value = "") ->
  value.replace(CASE_SEPARATORS_UNICODE, " ").trim().toLowerCase().split(CASE_WHITESPACE)

export toCamelCase = (value = "") ->
  toCase(value)?[0].toLowerCase() + toCase(value)?.slice(1).map(capitalize).join('')

export toConstantCase = (value = "") ->
  toCase(value).join("_").toUpperCase()

export toDotCase = (value = "") ->
  toCase(value).join(".")

export toKebabCase = (value = "") ->
  toCase(value).join("-")

export toPascalCase = (value = "") ->
  toCase(value).map(capitalize).join("")

export toSnakeCase = (value = "") ->
  toCase(value).join("_")

export toTitleCase = (value = "") ->
  toCase(value).map(capitalize).join(" ")
