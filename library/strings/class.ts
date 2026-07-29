import * as functions from "../../strings/functions";
import { applyFunctions } from "../../utilities/prototypes";

class Strings extends String {}

applyFunctions(functions, "Strings");

export default Strings;
