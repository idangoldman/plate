import Strings from "~/library/strings/class";
import * as functions from "~/library/strings/functions";
import * as Prototypes from "~/library/utilities/prototypes";

const apply = () => Prototypes.applyFunctions(functions, "String");
const remove = () => Prototypes.removeFunctions(Object.keys(functions), "String");

export default {
  Strings,
  apply,
  remove,
  ...functions
};

export { Strings, apply, remove };
