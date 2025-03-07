import path from "node:path"

import {
  STARTS_WITH_BASE_PATH,
  STARTS_WITH_PACKAGE_PATH,
  STARTS_WITH_PROJECT_PATH
} from "#root/helpers/regex.js"


export default (specifier) ->
  unless STARTS_WITH_BASE_PATH.test specifier
    return specifier

  unless process.env.PLATE_PRJ_PATH and process.env.PLATE_PKG_PATH
    throw new Error """
      Environment variables PLATE_PRJ_PATH and PLATE_PKG_PATH are not set.
      Please ensure you're running your code via the 'plate' command or set these variables manually.
    """

  if STARTS_WITH_PACKAGE_PATH.test specifier
    return path.join process.env.PLATE_PKG_PATH, specifier.replace STARTS_WITH_PACKAGE_PATH, ""

  if STARTS_WITH_PROJECT_PATH.test specifier
    return path.join process.env.PLATE_PRJ_PATH, specifier.replace STARTS_WITH_PROJECT_PATH, ""
