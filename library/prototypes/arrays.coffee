import Prototypes from "~/library/patterns/prototypes.coffee"

export default class Arrays extends Prototypes
  @extends "Array"

  # @around ["first", "last"], (fn) -> if @isEmpty then undefined else fn.call @

  excludes: (item) -> not @includes item
  first: -> @[0]
  last: -> @[@length - 1]
  flatten: -> [new Set(@flat(Infinity))...]

export methods = Arrays.methods()
