import Prototypes from "#root/patterns/prototypes.js"

export default class Is extends Prototypes
  @extends "Object"

  isArray:  (args...) -> Array.___isArray.apply null, args || [@]
  isObject: -> typeof @ == "object"
  isString: -> typeof @ == "string"

  isEmpty: ->
    switch true
      when @isArray()  then @length == 0
      when @isObject() then Object.___keys(@).length == 0
      when @isString() then @length == 0
      else false

export methods = Is.methods()
