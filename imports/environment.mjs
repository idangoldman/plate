import { deepFreezeMerge, importEnvironmentFile } from "@/imports/helpers.mjs";

(async () => {
  const configPathSuffix = "config/environment.yml";

  const PACKAGE_ENV = await importEnvironmentFile(`${PLATE_PKG}/${configPathSuffix}`);
  const PROJECT_ENV = await importEnvironmentFile(`${PLATE_PRJ}/${configPathSuffix}`);

  global.PLATE_ENV = deepFreezeMerge(PACKAGE_ENV, PROJECT_ENV);
})();
