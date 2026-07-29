import Objects from "~/library/objects/class";
import * as functions from "~/library/objects/functions";
import * as Prototypes from "~/library/utilities/prototypes";

const apply = () => Prototypes.applyFunctions(functions as any, "Object");
const remove = () => Prototypes.removeFunctions(Object.keys(functions), "Object");

export default {
  Objects,
  apply,
  remove,
  ...functions
};

export { Objects, apply, remove };
