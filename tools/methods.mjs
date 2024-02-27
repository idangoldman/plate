import fs from "node:fs/promises";
import merge from "lodash/merge.js";
import path from "node:path";

// Copy of https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/freeze
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

export async function importEnvironmentFile(...paths) {
  const ABSOLUTE_PATH = path.join(...paths);
  let environtmentFile = undefined;

  try {
    environtmentFile = (await import(ABSOLUTE_PATH)).default;
  } catch (e) {
    console.warn(`No environment file found at ${ABSOLUTE_PATH}`);
  } finally {
    return environtmentFile;
  }
}

export async function fileExists(filePath) {
  try {
    await fs.access(filePath, fs.constants.F_OK);
    return true;
  } catch {
    return false;
  }
}

const SNAKE_CASE_REGEX = new RegExp("[_]([a-z])", "gi");
const REMOVABLE_CHARACTERS = new RegExp("_+", "gi");
function snakeToCamel(str) {
  return str
    .replace(SNAKE_CASE_REGEX, (match, group1) => group1.toUpperCase())
    .replace(REMOVABLE_CHARACTERS, "");
}

export function transformKeysFromSnakeToCamel(obj) {
  if (Array.isArray(obj)) {
    return obj.map(transformKeysFromSnakeToCamel);
  }

  if (obj && typeof obj === "object") {
    return Object.entries(obj).reduce((newObject, [key, value]) => {
      newObject[snakeToCamel(key)] = transformKeysFromSnakeToCamel(value);
      return newObject;
    }, {});
  }

  return obj;
};

