// Copy of https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/freeze
// Usage: import deepFreezeMerge from './utils/deep-freeze.mjs'

import merge from "lodash/merge.js";

export function deepFreeze(object) {
  const propNames = Reflect.ownKeys(object);

  for (const name of propNames) {
    const value = object[name];

    if ((value && typeof value === "object") || typeof value === "function") {
      deepFreezeMerge(value);
    }
  }

  return Object.freeze(object);
}

export function deepFreezeMerge(...objects) {
  return deepFreeze(merge({}, ...objects));
}
