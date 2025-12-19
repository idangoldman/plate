import isEmpty from '~/library/arrays/functions/is-empty.coffee'

export default isNotEmpty = (arr) ->
  not isEmpty(arr)
