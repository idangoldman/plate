import Prototypes from "~/library/patterns/prototypes.coffee"

export default class To extends Prototypes
  @extends "Object"

  toArray: (separator = "") -> switch true
    when @isArray() then @slice()
    when @isObject() then Object.entries(@)
    when @isString()
      if @length is 0
      then []
      else unless separator?.isEmpty() then @.trim().split(separator)
      else [@]
    else [@]

  toObject: -> switch true
    when @isArray() then @reduce ((obj, value, index) -> obj[index] = value; obj), {}
    when @isObject() then Object.assign {}, @
    when @isString()
      if @length is 0 then {} else { 0: @ }
    else
      { 0: @ }

  toBoolean: -> switch true
    when @isArray()  then @length > 0
    when @isObject() then @keys().length > 0
    when @isString() then @length > 0
    else !!@

export methods = To.methods()
