import isArray from '~/library/methods/is/functions/is-array.coffee'
import isObject from '~/library/methods/is/functions/is-object.coffee'
import isString from '~/library/methods/is/functions/is-string.coffee'

export default toObject = (value) -> switch true
  when isArray(value) then value.reduce ((obj, val, index) -> obj[index] = val; obj), {}
  when isObject(value) then Object.assign {}, value
  when isString(value)
    if value.length is 0 then {} else { 0: value }
  else
    { 0: value }
