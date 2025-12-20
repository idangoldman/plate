import isArray from '~/library/methods/is/functions/is-array.coffee'
import isObject from '~/library/methods/is/functions/is-object.coffee'
import isString from '~/library/methods/is/functions/is-string.coffee'

export default toBoolean = (value) ->
  if isArray value
    return value.length > 0

  if isObject value
    return Object.keys(value).length > 0

  if isString value
    return value.length > 0

  Boolean(value)
