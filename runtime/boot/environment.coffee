import { deepMergeFreeze } from "#library/utilities/deep.coffee"
import { importEnvironmentFile } from "#runtime/utilities/import-environment-file.coffee"

do ->
  configFilePath = "configs/environment.yml"

  PACKAGE_CONF = await importEnvironmentFile "#{PLATE_PKG_PATH}/#{configFilePath}"
  PROJECT_CONF = await importEnvironmentFile "#{PLATE_PRJ_PATH}/#{configFilePath}"

  global.PLATE_CONF = deepMergeFreeze PACKAGE_CONF, PROJECT_CONF
