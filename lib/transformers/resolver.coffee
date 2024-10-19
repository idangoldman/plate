import { access } from "node:fs/promises"
import path from "node:path"

import {
  STARTS_WITH_BASE_PATH,
  STARTS_WITH_PACKAGE_PATH,
  STARTS_WITH_PROJECT_PATH
} from "#root/helpers/regex.js"

fileExists = (filePath) ->
  try
    await access(filePath, fs.constants.F_OK)
    true
  catch
    false

export default (specifier) ->
  { PLATE_PRJ_PATH, PLATE_PKG_PATH } = process.env

  unless PLATE_PRJ_PATH and PLATE_PKG_PATH and STARTS_WITH_BASE_PATH.test specifier
    return specifier

  if STARTS_WITH_PACKAGE_PATH.test specifier
    if PLATE_PKG_PATH isnt PLATE_PRJ_PATH
      projectPath = path.join PLATE_PRJ_PATH, specifier.replace STARTS_WITH_PACKAGE_PATH, ""

      if await fileExists projectPath
        return projectPath

    return path.join PLATE_PKG_PATH, specifier.replace STARTS_WITH_PACKAGE_PATH, ""

  if STARTS_WITH_PROJECT_PATH.test specifier
    path.join PLATE_PRJ_PATH, specifier.replace STARTS_WITH_PROJECT_PATH, ""
