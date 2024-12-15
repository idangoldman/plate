import Prototypes from "#root/patterns/prototypes.js"

export default class To extends Prototypes
  @extends "Object"

  toArray: -> switch true
    when @isArray()  then @slice()
    when @isObject() then @keys().map (key) -> [key, @get(key)]
    when @isString() then @split("")
    else []

  toObject: -> switch true
    when @isArray()  then @reduce (obj, value, index) -> obj[index] = value; obj, {}
    when @isObject() then @clone()
    when @isString() then @split("").reduce (obj, value, index) -> obj[index] = value; obj, {}
    else {}

  toBoolean: -> switch true
    when @isArray()  then @length > 0
    when @isObject() then @keys().length > 0
    when @isString() then @length > 0
    else !!@

  toNumber: -> switch true
    when @isArray()  then @length
    when @isObject() then @keys().length
    when @isString() then @length
    else +@

export methods = To.methods()
