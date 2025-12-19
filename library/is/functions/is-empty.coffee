import isArray from '~/library/methods/is/functions/is-array.coffee'
import isObject from '~/library/methods/is/functions/is-object.coffee'
import isString from '~/library/methods/is/functions/is-string.coffee'

export default isEmpty = (value) ->
  switch true
    when isArray(value)
      return value.length is 0

    when isObject(value)
      if Object.keys?
        return Object.keys(value).length is 0
      else
        for key of value
          return false if Object.prototype.hasOwnProperty.call(value, key)
        return true

    when isString(value)
      return value.length is 0

    when value instanceof Map or value instanceof Set
      return value.size is 0

    else
      return false
