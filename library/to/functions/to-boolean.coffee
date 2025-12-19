import isArray from '~/library/methods/is/functions/is-array.coffee'
import isObject from '~/library/methods/is/functions/is-object.coffee'
import isString from '~/library/methods/is/functions/is-string.coffee'

export default toBoolean = (value) -> switch true
  when isArray(value)  then value.length > 0
  when isObject(value) then Object.keys(value).length > 0
  when isString(value) then value.length > 0
  else Boolean(value)
