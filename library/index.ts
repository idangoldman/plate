// Prototype extension is opt-in. Importing this module gives you the pure
// functions and classes only. For native prototype methods plus their types:
//
//   import "@idangoldman/plate/globals";

// Arrays
import * as ArrayFunctions from "~/library/arrays/functions";
import { Arrays, apply as applyArrays, remove as removeArrays } from "~/library/arrays/index";
export { ArrayFunctions, Arrays, applyArrays, removeArrays };

// Strings
import * as StringFunctions from "~/library/strings/functions";
import { Strings, apply as applyStrings, remove as removeStrings } from "~/library/strings/index";
export { StringFunctions, Strings, applyStrings, removeStrings };

// Objects
import * as ObjectFunctions from "~/library/objects/functions";
import { Objects, apply as applyObjects, remove as removeObjects } from "~/library/objects/index";
export { ObjectFunctions, Objects, applyObjects, removeObjects };

// Events
import Events from "~/library/patterns/events";
import DOMEvents from "~/library/events/dom";
export { Events, DOMEvents };
export type { EventCallback } from "~/library/patterns/events";

/** Extends `Array`, `String` and `Object` prototypes. */
export function applyAll(): void {
  applyArrays();
  applyStrings();
  applyObjects();
}

/** Reverses `applyAll`, restoring shadowed native methods. */
export function removeAll(): void {
  removeArrays();
  removeStrings();
  removeObjects();
}
