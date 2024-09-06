import { access } from "node:fs/promises"
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
      projectPath = specifier.replace STARTS_WITH_PACKAGE_PATH, PLATE_PRJ_PATH

      return projectPath if await fileExists projectPath

    return specifier.replace STARTS_WITH_PACKAGE_PATH, PLATE_PKG_PATH

  if STARTS_WITH_PROJECT_PATH.test specifier
    specifier.replace STARTS_WITH_PROJECT_PATH, PLATE_PRJ_PATH
