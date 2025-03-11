import Prototypes from "#root/patterns/prototypes.js"
import capitalize from "#root/helpers/capitalize.js"
import { CASE_SEPARATORS, CASE_WHITESPACE } from "#root/helpers/regex.js"

export default class Strings extends Prototypes
  @extends "String"

  capitalize: => capitalize @

  times: (x = 1, y = 1) ->
    Array(y)
      .fill Array(x).fill(@).join("")
      .join "\n"

export methods = Strings.methods()
