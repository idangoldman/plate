import * as functions from "~/library/strings/functions";
import { applyFunctions } from "~/library/utilities/prototypes";

class Strings extends String {}

applyFunctions(functions, "Strings");

export default Strings;
