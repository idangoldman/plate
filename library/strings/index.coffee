import Strings from "~/library/strings/class.coffee"
import * as functions from "~/library/strings/functions"
import Prototypes from "~/library/utilities/prototypes.coffee"

export default {
  Strings,
  apply: -> Prototypes.applyFunctions(functions, "String"),
  remove: -> Prototypes.removeFunctions(Object.keys(functions), "String")
  functions...
}
