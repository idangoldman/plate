import isArray from '~/library/objects/functions/is-array.coffee'
import isObject from '~/library/objects/functions/is-object.coffee'
import isString from '~/library/objects/functions/is-string.coffee'

export default toObject = (value) ->
  if isArray(value)
    return value.reduce ((obj, val, index) -> obj[index] = val; obj), {}

  if isObject(value)
    return Object.assign {}, value

  if isString(value)
    return if value.length is 0 then {} else { 0: value }

  return { 0: value }
