import Arrays from "~/library/arrays/class.coffee"
import functions from "~/library/arrays/functions/*.coffee"
import Prototypes from "~/library/utilities/prototypes.coffee"

export default Arrays
export { functions... }

export apply = -> Prototypes.applyFunctions(functions, "Array")
export remove = -> Prototypes.removeFunctions(Object.keys(functions), "Array")
