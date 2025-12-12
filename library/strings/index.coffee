import Strings from "~/library/strings/class.coffee"
import * as functions from "~/library/strings/functions.coffee"
import Prototypes from "~/library/utilities/prototypes.coffee"

export { Strings, functions... }
export default Strings

export apply = -> Prototypes.applyFunctions(functions, "String")
export remove = -> Prototypes.removeFunctions(Object.keys(functions), "String")
