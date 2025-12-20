export default isObject = (value) ->
  typeof value is "object" and Array.isArray(value) is false and value isnt null
