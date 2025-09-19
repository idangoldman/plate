import Prototypes from "#root/patterns/prototypes.js"

export default class Arrays extends Prototypes
  @extends "Array"

  # @around ["first", "last"], (fn) -> if @isEmpty then undefined else fn.call @

  excludes: (element) -> not @includes element
  first: -> @[0]
  last: -> @[@length - 1]
  flatten: -> [new Set(@flat(Infinity))...]

export methods = Arrays.methods()
