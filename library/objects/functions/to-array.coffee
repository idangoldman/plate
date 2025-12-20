import isArray from '~/library/objects/functions/is-array.coffee'
import isObject from '~/library/objects/functions/is-object.coffee'
import isString from '~/library/objects/functions/is-string.coffee'
import isEmpty from '~/library/strings/functions/is-empty.coffee'

export default toArray = (value, separator = "") ->
  if isArray value
    return value.slice()

  if isObject value
    return Object.entries(value)

  if isString value
    if value.length is 0
      return []
    else unless isEmpty(separator)
      return value.trim().split(separator)
    else
      return [value]

  return [value]
