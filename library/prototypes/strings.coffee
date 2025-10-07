import Prototypes from "#library/patterns/prototypes.coffee"
import capitalize from "#library/utilities/capitalize.coffee"

export default class Strings extends Prototypes
  @extends "String"

  capitalize: -> capitalize @

  times: (x = 1, y = 1) ->
    Array(y)
      .fill Array(x).fill(@).join("")
      .join "\n"

export methods = Strings.methods()
