import Strings from "~/library/strings/class";
import * as functions from "~/library/strings/functions";
import { applyFunctions, removeFunctions } from "~/library/utilities/prototypes";

const apply = () => applyFunctions(functions, "String");
const remove = () => removeFunctions(Object.keys(functions), "String");

export default {
  Strings,
  apply,
  remove,
  ...functions,
};

export { Strings, apply, remove };
