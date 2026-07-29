import Objects from "~/library/objects/class";
import * as functions from "~/library/objects/functions";
import * as Prototypes from "~/library/utilities/prototypes";

// Objects cannot iterate over Object properties normally if they are non-enumerable
// but the functions imported are simple properties on the object literal, so applyFunctions works
const apply = () => Prototypes.applyFunctions(functions as any, "Object");
const remove = () => Prototypes.removeFunctions(Object.keys(functions), "Object");

export default {
  Objects,
  apply,
  remove,
  ...functions
};

export { Objects, apply, remove };
