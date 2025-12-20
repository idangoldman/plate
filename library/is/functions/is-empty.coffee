import isArray from '~/library/methods/is/functions/is-array.coffee'
import isObject from '~/library/methods/is/functions/is-object.coffee'
import isString from '~/library/methods/is/functions/is-string.coffee'

export default isEmpty = (value) ->
  if isArray value
    return value.length is 0

  if isObject value
    if Object.keys?
      return Object.keys(value).length is 0

    for key of value
      return false if Object.prototype.hasOwnProperty.call(value, key)

    return true

  if isString value
    return value.length is 0

  if value instanceof Map or value instanceof Set
    return value.size is 0

  return false
