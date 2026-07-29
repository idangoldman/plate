import Prototypes from "#root/patterns/prototypes.js"
import capitalize from "#root/helpers/capitalize.js"

export default class Strings extends Prototypes
  @extends "String"

  capitalize: -> capitalize @

  times: (n) ->
    # Ensure n is a non-negative integer
    count = parseInt(n, 10)
    if isNaN(count) or count <= 0
      return ""
    # Repeat the string 'count' times
    return @toString().repeat(count)

export methods = Strings.methods()
