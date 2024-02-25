import { fileExists } from "../../tools/methods.mjs";

export async function resolve(specifier, context, nextResolve) {
  if (specifier.startsWith("~/")) {
    const { PLATE_ROOT, PLATE_PKG } = process.env;
    let updatedSpecifier = specifier.replace(/^~/, PLATE_PKG);

    if (PLATE_ROOT !== PLATE_PKG) {
      const rootPath = specifier.replace(/^~/, PLATE_ROOT);

      if (fileExists(rootPath)) {
        updatedSpecifier = rootPath;
      }
    }

    return nextResolve(updatedSpecifier);
  }

  return nextResolve(specifier, context, nextResolve);
}
