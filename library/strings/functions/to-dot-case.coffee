import toCase from '~/library/strings/functions/to-case.coffee'

export default toDotCase = (value = "") ->
  toCase(value).join(".")
