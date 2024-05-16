import { access } from "node:fs/promises";

async function fileExists(filePath) {
  try {
    await access(filePath, fs.constants.F_OK);
    return true;
  } catch {
    return false;
  }
}

export const pathStartsWith = new RegExp("^([~|@]/)");
export const packagePathPrefix = "~/";
export const projectPathPrefix = "@/";

export async function pathResolver(specifier) {
  let updatedSpecifier = specifier;

  if (specifier.startsWith(packagePathPrefix)) {
    const { PLATE_PRJ, PLATE_PKG } = process.env;
    updatedSpecifier = specifier.replace(/^~/, PLATE_PKG);

    if (PLATE_PRJ !== PLATE_PKG) {
      const projectPath = specifier.replace(/^~/, PLATE_PRJ);

      if (await fileExists(projectPath)) {
        updatedSpecifier = projectPath;
      }
    }
  }

  if (specifier.startsWith(projectPathPrefix)) {
    const { PLATE_PKG } = process.env;
    updatedSpecifier = specifier.replace(/^@/, PLATE_PKG);
  }

  return updatedSpecifier;
}
