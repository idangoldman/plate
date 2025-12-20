import isEmpty from '~/library/arrays/functions/is-empty.coffee'

export default first = (arr) ->
  arr[0] unless isEmpty(arr)
