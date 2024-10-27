import PrototypeBase from "#root/methods/prototypes/base.js"

export default class PrototypeArray extends PrototypeBase
  @extends "Array"

  @around ["first", "last"], (fn) -> if @isEmpty then undefined else fn.call(@)

  first:   -> @[0]
  from:    (index) -> @slice(index)
  isEmpty: -> @length is 0
  last:    -> @[@length - 1]

export methods = PrototypeArray.methods()
