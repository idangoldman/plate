import toCase from '~/library/strings/functions/to-case.coffee'

export default toKebabCase = (value = "") ->
  toCase(value).join("-")
