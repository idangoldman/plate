import * as methods from "~/library/strings/functions/index.coffee"
import { applyFunctions } from "~/library/utilities/prototypes.coffee"

class Strings extends String

applyFunctions methods, "Strings"

export default Strings
