import Prototypes from "#root/patterns/prototypes.js"

export default class Is extends Prototypes
  @extends "Object"

  isArray:  (args...) -> Array.___isArray.apply null, args || [@]
  isObject: -> typeof @ == "object"
  isString: -> typeof @ == "string"

  isEmpty: ->
    switch true
      when @isArray()  then @length == 0
      when @isObject() then @keys().length == 0
      when @isString() then @length == 0
      else false

  type: () ->
    Object.prototype.toString.call @
      .toLowerCase()
      .replace(/\[object (.*)\]/, "$1") || "undefined"

export methods = Is.methods()
