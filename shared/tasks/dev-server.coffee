import browserSync from "browser-sync"

{ globs, server } = PLATE_ENV

export Serve = (next) ->
  browserSync.init
    port: server.port
    server: globs.public
    startPath: server.path
  next()

export Reload = (next) ->
  browserSync.reload()
  next()
