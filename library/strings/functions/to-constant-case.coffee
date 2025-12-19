import toCase from '~/library/strings/functions/to-case.coffee'

export default toConstantCase = (value = "") ->
  toCase(value).join("_").toUpperCase()
