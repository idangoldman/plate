import browserSync from "browser-sync"

{ globs, server } = PLATE_ENV

export Serve = (next) ->
  browserSync.init
    server: globs.public
    port: server.port
  next()

export Reload = (next) ->
  browserSync.reload()
  next()
