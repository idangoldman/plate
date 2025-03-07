import Prototypes from "#root/patterns/prototypes.js"

export default class Is extends Prototypes
  @extends "Object"

  # isArray:  (args...) -> Array.___isArray.apply null, args || [@]
  isArray:  -> Array.isArray @
  isObject: -> typeof @ == "object" && @ != null
  isString: -> typeof @ == "string"

  isEmpty: ->
    switch true
      when @isArray()
        return @length == 0
      when @isObject()
        if Object.keys?
          return Object.keys(@).length == 0
        else
          for key of @
            return false if Object.prototype.hasOwnProperty.call(@, key)
          return true
      when @isString()
        return @length == 0
      when @ instanceof Map || @ instanceof Set
        return @size == 0
      else
        return false

export methods = Is.methods()
