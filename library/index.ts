// import './global.d.ts';

// Arrays
import * as ArrayFunctions from './arrays/functions';
import { applyFunctions as applyArrayFunctions } from './utilities/prototypes';
export { ArrayFunctions };

// Strings
import * as StringFunctions from './strings/functions';
import { applyFunctions as applyStringFunctions } from './utilities/prototypes';
export { StringFunctions };

// Objects
import * as ObjectFunctions from './objects/functions';
import { applyFunctions as applyObjectFunctions } from './utilities/prototypes';
export { ObjectFunctions };

// Events
import Events from './patterns/events';
import DOMEvents from './events/dom';
export { Events, DOMEvents };

// Auto-apply logic
export function applyAll() {
  applyArrayFunctions(ArrayFunctions, "Array");
  applyStringFunctions(StringFunctions, "String");
  applyObjectFunctions(ObjectFunctions as any, "Object");
}
