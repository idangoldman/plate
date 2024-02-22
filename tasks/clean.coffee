import { deleteSync } from "del"

{ globs } = PLATE_ENV

export default Clean = (done) ->
  deleteSync globs.clean, { dot: true, force: true }
  done()
