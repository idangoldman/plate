import { deleteSync } from "del"
import { globs } from "../config/environment.yml"

export default Clean = (done) ->
  deleteSync globs.clean, { dot: true, force: true }
  done()
