import { access } from "node:fs/promises";
import {
  STARTS_WITH_BASE_PATH,
  STARTS_WITH_PACKAGE_PATH,
  STARTS_WITH_PROJECT_PATH,
} from "#root/tools/regex.coffee";

async function fileExists(filePath) {
  try {
    await access(filePath, fs.constants.F_OK);
    return true;
  } catch {
    return false;
  }
}

export async function pathResolver(specifier) {
  const { PLATE_PRJ_PATH, PLATE_PKG_PATH } = process.env;

  if (!PLATE_PRJ_PATH || !PLATE_PKG_PATH) {
    return specifier;
  }

  if (!STARTS_WITH_BASE_PATH.test(specifier)) {
    return specifier;
  }

  if (STARTS_WITH_PACKAGE_PATH.test(specifier)) {
    if (PLATE_PKG_PATH !== PLATE_PRJ_PATH) {
      const projectPath = specifier.replace(
        STARTS_WITH_PACKAGE_PATH,
        PLATE_PRJ_PATH,
      );

      if (await fileExists(projectPath)) {
        return projectPath;
      }
    }

    return specifier.replace(STARTS_WITH_PACKAGE_PATH, PLATE_PKG_PATH);
  }

  if (STARTS_WITH_PROJECT_PATH.test(specifier)) {
    return specifier.replace(STARTS_WITH_PROJECT_PATH, PLATE_PRJ_PATH);
  }
}
