import Prototypes from "#root/patterns/prototypes.js"
import capitalize from "#root/helpers/capitalize.js"

export default class Objects extends Prototypes
  @extends "Object"

  # keys:   (args...) -> Object.___keys.apply null, args || [@]
  keys: -> Object.keys @

  print: ->
    messages = [
      "####################"
      "####################"
      JSON.stringify @, null, 2
      "####################"
      "####################"
    ]

    for message in messages
      console.log message

  toCaseKeys: (caseType) ->
    prototypeName = "to#{capitalize caseType}Case"
    result = {}

    for own key, value of @
      newKey = key["#{prototypeName}"]()

      result[newKey] = if typeof value is "object" and value?
        value.toCaseKeys caseType
      else
        value

    result

  toCamelCaseKeys: ->    @toCaseKeys "camel"
  toConstantCaseKeys: -> @toCaseKeys "constant"
  toKebabCaseKeys: ->    @toCaseKeys "kebab"
  toPascalCaseKeys: ->   @toCaseKeys "pascal"
  toSnakeCaseKeys: ->    @toCaseKeys "snake"

export methods = Objects.methods()
