import { deepFreezeMerge } from "#root/helpers/deep.js"
import { importEnvironmentFile } from "#root/helpers/import-environment-file.js"

do ->
  configFilePath = "configs/environment.yml"

  PACKAGE_CONF = await importEnvironmentFile "#{PLATE_PKG_PATH}/#{configFilePath}"
  PROJECT_CONF = await importEnvironmentFile "#{PLATE_PRJ_PATH}/#{configFilePath}"

  global.PLATE_CONF = deepFreezeMerge PACKAGE_CONF, PROJECT_CONF
