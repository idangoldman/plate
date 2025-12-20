import Arrays from "~/library/arrays/class.coffee"
import * as functions from "~/library/arrays/functions"
import Prototypes from "~/library/utilities/prototypes.coffee"

export default {
  Arrays,
  apply: -> Prototypes.applyFunctions(functions, "Array"),
  remove: -> Prototypes.removeFunctions(Object.keys(functions), "Array")
  functions...
}
