import { deepFreezeMerge, importEnvironmentFile } from "@/tools/methods.mjs";
import gulp from "gulp";

global.PLATE_ENV  = {};
global.PLATE_PKG  = process.env.PLATE_PKG;
global.PLATE_ROOT = process.env.PLATE_ROOT;
global.gulp = gulp;

(async () => {
  const PACKAGE_ENV = await importEnvironmentFile(PLATE_PKG, "shared/environment.yml");
  const PROJECT_ENV = await importEnvironmentFile(PLATE_ROOT, "environment.yml");

  global.PLATE_ENV = deepFreezeMerge(PACKAGE_ENV, PROJECT_ENV);
})();
