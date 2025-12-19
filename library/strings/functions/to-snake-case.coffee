import toCase from '~/library/strings/functions/to-case.coffee'

export default toSnakeCase = (value = "") ->
  toCase(value).join("_")
