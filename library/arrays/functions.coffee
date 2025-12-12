export excludes = (arr, item) ->
  not arr.includes item

export first = (arr) ->
  arr[0] unless isEmpty(arr)

export flatten = (arr) ->
  unique(arr.flat(Infinity))

export isEmpty = (arr) ->
  arr.length is 0

export isNotEmpty = (arr) ->
  not isEmpty(arr)

export last = (arr) ->
  arr[arr.length - 1] unless isEmpty(arr)

export unique = (arr) ->
  [new Set(arr)...]
