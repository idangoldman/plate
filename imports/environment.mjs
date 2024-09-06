import { deepFreezeMerge, importEnvironmentFile } from "@/imports/helpers.mjs";

(async () => {
  const configPathSuffix = "configs/environment.yml";

  const PACKAGE_ENV = await importEnvironmentFile(
    `${PLATE_PKG_PATH}/${configPathSuffix}`,
  );
  const PROJECT_ENV = await importEnvironmentFile(
    `${PLATE_PRJ_PATH}/${configPathSuffix}`,
  );

  global.PLATE_CONF = deepFreezeMerge(PACKAGE_ENV, PROJECT_ENV);
})();
