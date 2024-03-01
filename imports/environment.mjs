import { deepFreezeMerge, importEnvironmentFile } from "@/tools/methods.mjs";

(async () => {
  const PACKAGE_ENV = await importEnvironmentFile(PLATE_PKG, "shared/environment.yml");
  const PROJECT_ENV = await importEnvironmentFile(PLATE_ROOT, "environment.yml");

  global.PLATE_ENV = deepFreezeMerge(PACKAGE_ENV, PROJECT_ENV);
})();
