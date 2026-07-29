import Strings from "../../strings/class";
import * as functions from "../../strings/functions";
import * as Prototypes from "../../utilities/prototypes";

const apply = () => Prototypes.applyFunctions(functions, "String");
const remove = () => Prototypes.removeFunctions(Object.keys(functions), "String");

export default {
  Strings,
  apply,
  remove,
  ...functions
};

export { Strings, apply, remove };
