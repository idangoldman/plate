import { deleteSync } from "del"

export default Clean = (next) ->
  deleteSync PLATE_ENV.globs.clean, { dot: true, force: true }
  next()
