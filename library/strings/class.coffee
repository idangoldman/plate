import * as functions from "~/library/strings/functions"
import { applyFunctions } from "~/library/utilities/prototypes.coffee"

class Strings extends String

applyFunctions functions, "Strings"

export default Strings
