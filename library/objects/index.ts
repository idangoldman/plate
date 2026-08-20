import Objects from "~/library/objects/class";
import * as functions from "~/library/objects/functions";
import { applyFunctions, removeFunctions } from "~/library/utilities/prototypes";

// `applyFunctions` accepts `Record<string, unknown>`, so the namespace object
// passes with no cast. Non-function members are skipped inside it.
const apply = () => applyFunctions(functions, "Object");
const remove = () => removeFunctions(Object.keys(functions), "Object");

export default {
  Objects,
  apply,
  remove,
  ...functions,
};

export { Objects, apply, remove };
