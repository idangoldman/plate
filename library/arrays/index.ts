import Arrays from "~/library/arrays/class";
import * as functions from "~/library/arrays/functions";
import { applyFunctions, removeFunctions } from "~/library/utilities/prototypes";

const apply = () => applyFunctions(functions, "Array");
const remove = () => removeFunctions(Object.keys(functions), "Array");

export default {
  Arrays,
  apply,
  remove,
  ...functions,
};

export { Arrays, apply, remove };
