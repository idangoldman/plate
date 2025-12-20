import Objects from "~/library/objects/class.coffee"
import * as functions from "~/library/objects/functions"
import Prototypes from "~/library/utilities/prototypes.coffee"

export default {
  Objects,
  apply: -> Prototypes.applyFunctions(functions, "Object"),
  remove: -> Prototypes.removeFunctions(Object.keys(functions), "Object")
  functions...
}
