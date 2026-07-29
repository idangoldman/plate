import * as functions from "~/library/arrays/functions";
import { applyFunctions } from "~/library/utilities/prototypes";

class Arrays extends Array {}

applyFunctions(functions, "Arrays");

export default Arrays;
