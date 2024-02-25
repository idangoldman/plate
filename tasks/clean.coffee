import { deleteSync } from "del"

export default Clean = (done) ->
  deleteSync PLATE_ENV.globs.clean, { dot: true, force: true }
  done()
