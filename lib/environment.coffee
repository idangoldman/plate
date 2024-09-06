import { deepFreezeMerge, importEnvironmentFile } from "#root/src/imports/helpers.js"

do ->
  configFilePath = "configs/environment.yml"

  PACKAGE_CONF = await importEnvironmentFile "#{PLATE_PKG_PATH}/#{configFilePath}"
  PROJECT_CONF = await importEnvironmentFile "#{PLATE_PRJ_PATH}/#{configFilePath}"

  global.PLATE_CONF = deepFreezeMerge PACKAGE_CONF, PROJECT_CONF
