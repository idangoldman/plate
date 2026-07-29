import Arrays from "../../arrays/class";
import * as functions from "../../arrays/functions";
import * as Prototypes from "../../utilities/prototypes";

const apply = () => Prototypes.applyFunctions(functions, "Array");
const remove = () => Prototypes.removeFunctions(Object.keys(functions), "Array");

export default {
  Arrays,
  apply,
  remove,
  ...functions
};

export { Arrays, apply, remove };
