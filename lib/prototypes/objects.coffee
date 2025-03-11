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

export methods = Objects.methods()
