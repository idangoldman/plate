import isArray from '~/library/methods/is/functions/is-array.coffee'
import isObject from '~/library/methods/is/functions/is-object.coffee'
import isString from '~/library/methods/is/functions/is-string.coffee'
import isEmpty from '~/library/methods/is/functions/is-empty.coffee'

export default toArray = (value, separator = "") -> switch true
  when isArray(value) then value.slice()
  when isObject(value) then Object.entries(value)
  when isString(value)
    if value.length is 0
    then []
    else unless isEmpty(separator) then value.trim().split(separator)
    else [value]
  else [value]
