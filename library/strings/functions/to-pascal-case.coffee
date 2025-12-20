import toCase from '~/library/strings/functions/to-case.coffee'
import capitalize from '~/library/strings/functions/capitalize.coffee'

export default toPascalCase = (value = "") ->
  toCase(value).map(capitalize).join("")
