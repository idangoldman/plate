import capitalize from '~/library/strings/functions/capitalize.coffee'

export default toCaseKeys = (obj, caseType = "") ->
  prototypeName = "to#{capitalize caseType}Case"
  result = {}

  for own key, value of obj
    newKey = key["#{prototypeName}"]()

    result[newKey] = if typeof value is "object" and Array.isArray(value) is false and value?
      toCaseKeys value, caseType
    else
      value

  result
