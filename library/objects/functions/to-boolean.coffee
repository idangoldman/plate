import isArray from '~/library/objects/functions/is-array.coffee'
import isObject from '~/library/objects/functions/is-object.coffee'
import isString from '~/library/objects/functions/is-string.coffee'
import isEmpty as isEmptyString from '~/library/strings/functions/is-empty.coffee'
import isEmpty as isEmptyArray from '~/library/arrays/functions/is-empty.coffee'
import isEmpty as isEmptyObject from '~/library/objects/functions/is-empty.coffee'

export default toBoolean = (value) ->
  if isArray value
    return not isEmptyArray value

  if isObject value
    return not isEmptyObject value

  if isString value
    return not isEmptyString value

  Boolean(value)
