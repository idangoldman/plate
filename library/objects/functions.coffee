import { capitalize } from "~/library/strings/functions.coffee"

export toCaseKeys = (caseType = "") ->
  prototypeName = "to#{capitalize caseType}Case"
  result = {}

  for own key, value of @
    newKey = key["#{prototypeName}"]()

    result[newKey] = if typeof value is "object" and Array.isArray(value) is false and value?
      value.toCaseKeys caseType
    else
      value

  result

export keys = (obj = {}) ->
  Object.keys(obj)

export values = (obj = {}) ->
  Object.values(obj)