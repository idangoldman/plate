Array::first = ->
  @[0]

Array::last = ->
  @[@length - 1]

# Array.hooks.around ["first", "last"], (fn) ->
#     if @length is 0
#        then undefined
#        else fn.call(@)
