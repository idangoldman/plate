import toCase from '~/library/strings/functions/to-case.coffee'
import capitalize from '~/library/strings/functions/capitalize.coffee'

export default toCamelCase = (value = "") ->
  toCase(value)?[0].toLowerCase() + toCase(value)?.slice(1).map(capitalize).join('')
