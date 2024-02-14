import { globs, server } from "../config/environment.yml"
import browserSync from "browser-sync"

export Serve = (done) ->
  browserSync.init
    server: globs.public
    port: server.port
  done()

export Reload = (done) ->
  browserSync.reload()
  done()
