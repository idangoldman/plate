import { deepFreezeMerge } from "./methods.mjs";
import fs from "node:fs"
import path from "node:path"
import YAML from "js-yaml"

global.PLATE_ENV = (() => {
  const PACKAGE_FILE_PATH = path.join(import.meta.dirname, '../config/environment.yml');
  const PROJECT_FILE_PATH = path.join(process.cwd(), "config/environment.yml");

  const PACKAGE_ENV = YAML.load(fs.readFileSync(PACKAGE_FILE_PATH, "utf8"));
  const PROJECT_ENV = YAML.load(fs.readFileSync(PROJECT_FILE_PATH, "utf8"));

  return deepFreezeMerge(PACKAGE_ENV, PROJECT_ENV);
})();
