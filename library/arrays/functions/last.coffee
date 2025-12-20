import isEmpty from '~/library/arrays/functions/is-empty.coffee'

export default last = (arr) ->
  arr[arr.length - 1] unless isEmpty(arr)
