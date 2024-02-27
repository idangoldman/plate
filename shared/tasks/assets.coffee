globs = PLATE_ENV.globs.assets

export default Assets = ->
  gulp.src globs.src
    .pipe gulp.dest globs.dest
