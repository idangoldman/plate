import unique from '~/library/arrays/functions/unique.coffee'

export default flatten = (arr) ->
  unique(arr.flat(Infinity))
