import Objects from "~/library/objects/class.coffee"
import * as functions from "~/library/objects/functions.coffee"
import Prototypes from "~/library/utilities/prototypes.coffee"

export { Objects, functions... }
export default Objects

export apply = -> Prototypes.applyFunctions(functions, "Object")
export remove = -> Prototypes.removeFunctions(Object.keys(functions), "Object")
