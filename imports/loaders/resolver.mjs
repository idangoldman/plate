import fs from "node:fs/promises";

async function fileExists(filePath) {
  try {
    await fs.access(filePath, fs.constants.F_OK);
    return true;
  } catch {
    return false;
  }
}

export async function resolve(specifier, context, nextResolve) {
  if (specifier.startsWith("~/")) {
    const { PLATE_ROOT, PLATE_PKG } = process.env;
    let updatedSpecifier = specifier.replace(/^~/, `${PLATE_PKG}/shared`);

    if (PLATE_ROOT !== PLATE_PKG) {
      const rootPath = specifier.replace(/^~/, PLATE_ROOT);

      if (await fileExists(rootPath)) {
        updatedSpecifier = rootPath;
      }
    }

    return nextResolve(updatedSpecifier);
  }

  if (specifier.startsWith("@/")) {
    const { PLATE_PKG } = process.env;
    const updatedSpecifier = specifier.replace(/^@/, `${PLATE_PKG}/`);

    return nextResolve(updatedSpecifier);
  }

  return nextResolve(specifier, context, nextResolve);
}
