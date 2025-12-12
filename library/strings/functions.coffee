import { CASE_SEPARATORS, CASE_WHITESPACE } from "~/library/utilities/regex.coffee"

export capitalize = (str = "") ->
  unless str.length > 0 then "" else str.charAt(0).toUpperCase() + str.slice(1).toLowerCase()

export toCase(value = "")
  @replace(CASE_SEPARATORS, " $1").trim().toLowerCase().split(CASE_WHITESPACE)

export toCamelCase(value = "")
  @toCase().first().toLowerCase() + @toCase().slice(1).map(capitalize).join('')

export toConstantCase(value = "")
  @toCase().join("_").toUpperCase()

export toDotCase(value = "")
  @toCase().join(".")

export toKebabCase(value = "")
  @toCase().join("-")

export toPascalCase(value = "")
  @toCase().map(capitalize).join("")

export toSnakeCase(value = "")
  @toCase().join("_")

export toTitleCase(value = "")
  @toCase().map(capitalize).join(" ")
