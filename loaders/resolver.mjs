import { fileExists } from "../utils/methods.mjs";
import path from "node:path";

// TODO: Replace with a more robust check for the ~/tasks directory
export async function resolve(specifier, context, defaultResolve) {
  if (specifier.includes("~/tasks/main.coffee")) {
    const { PLATE_PKG, PLATE_ROOT } = process.env;
    let updatedSpecifier = path.join(PLATE_PKG, "tasks", "main.coffee");

    if (PLATE_ROOT !== PLATE_PKG) {
      const rootPath = path.join(PLATE_ROOT, "tasks", "main.coffee");

      if (fileExists(rootPath)) {
        updatedSpecifier = rootPath;
      }
    }

    return defaultResolve(updatedSpecifier);
  }

  return defaultResolve(specifier, context, defaultResolve);
}
