import browserSync from "browser-sync"

{ globs, server } = PLATE_ENV

export Serve = (done) ->
  browserSync.init
    server: globs.public
    port: server.port
  done()

export Reload = (done) ->
  browserSync.reload()
  done()
