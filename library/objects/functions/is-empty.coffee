import isArray from '~/library/objects/functions/is-array.coffee'
import isEmpty as isEmptyArray from '~/library/arrays/functions/is-empty.coffee'
import isEmpty as isEmptyString from '~/library/strings/functions/is-empty.coffee'
import isObject from '~/library/objects/functions/is-object.coffee'
import isString from '~/library/objects/functions/is-string.coffee'

export default isEmpty = (value) ->
  if isArray value
    return isEmptyArray value

  if isObject value
    return Object.keys(value).length is 0

  if isString value
    return isEmptyString value

  if value instanceof Map or value instanceof Set
    return value.size is 0

  return false
