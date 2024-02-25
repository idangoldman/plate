import { deepFreezeMerge, importEnvironmentFile } from "./methods.mjs";

global.PLATE_ENV  = {};
global.PLATE_PKG  = process.env.PLATE_PKG;
global.PLATE_ROOT = process.env.PLATE_ROOT;

(async () => {
  const PACKAGE_ENV = await importEnvironmentFile(PLATE_PKG, "config/environment.yml");
  const PROJECT_ENV = await importEnvironmentFile(PLATE_ROOT, "environment.yml");

  global.PLATE_ENV = deepFreezeMerge(PACKAGE_ENV, PROJECT_ENV);
})();
