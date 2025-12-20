import Objects from "~/library/objects/class.coffee"
import functions from "~/library/objects/*.coffee"
import Prototypes from "~/library/utilities/prototypes.coffee"

export { functions... }
export default Objects

export apply = -> Prototypes.applyFunctions(functions, "Object")
export remove = -> Prototypes.removeFunctions(Object.keys(functions), "Object")
