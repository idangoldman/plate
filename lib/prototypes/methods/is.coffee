import Prototypes from "#root/patterns/prototypes.js"

export default class Is extends Prototypes
  @extends "Object"

  # isArray:  (args...) -> Array.___isArray.apply null, args or [@]
  isArray: ->  Array.isArray @
  isObject: -> typeof @ is "object" and Array.isArray(@) is false and @ isnt null
  isString: -> typeof @ is "string"
  # isNumber: ->
  #   typeof @ is "number"
  #     ? @ - @ is 0
  #     : typeof @ is 'string' and @.trim() isnt ''
  #       ? (Number.isFinite ? Number.isFinite(+num) : isFinite(+num))
  #       : false


  isEmpty: ->
    switch true
      when @isArray()
        return @length is 0
      when @isObject()
        if Object.keys?
          return Object.keys(@).length is 0
        else
          for key of @
            return false if Object.prototype.hasOwnProperty.call(@, key)
          return true
      when @isString()
        return @length is 0
      when @ instanceof Map or @ instanceof Set
        return @size is 0
      else
        return false

export methods = Is.methods()
