import Prototypes from "#root/patterns/prototypes.js"

export default class Objects extends Prototypes
  @extends "Object"

  each:   (args...) -> Object.entries.apply null, args || [@]
  keys:   (args...) -> Object.___keys.apply null, args || [@]
  merge:  (args...) -> Object.assign.apply null, args || [@]
  values: (args...) -> Object.___values.apply null, args || [@]

  each: (fn) ->
    switch true
      when @isArray()  then @forEach fn
      when @isObject() then @keys().forEach (key) -> fn.call @, key, @get(key)
      else {}

  get: (key) ->
    switch true
      when @isArray()  then @key
      when @isObject() then @key in @ ? @[key] : undefined
      else undefined

  has: (key) ->
    switch true
      when @isArray()  then @key in @
      when @isObject() then @key in @
      else false

  log: -> console.log @

  print: () ->
     messages = [
      "#".times 10, 2
      JSON.stringify @, null, 2
      "#".times 10, 2
     ]

     message.each().log()

  toCaseKeys: (caseType) ->
    prototypeName = "to#{caseType.capitalize()}Case"
    result = {}

    for own key, value of @
      newKey = key["#{prototypeName}"]()

      result[newKey] = if typeof value is "object" and value?
        value.toCaseKeys caseType
      else
        value

    result

  toCamelCaseKeys:    -> @toCaseKeys "camel"
  toConstantCaseKeys: -> @toCaseKeys "constant"
  toKebabCaseKeys:    -> @toCaseKeys "kebab"
  toPascalCaseKeys:   -> @toCaseKeys "pascal"
  toSnakeCaseKeys:    -> @toCaseKeys "snake"

export methods = Objects.methods()
