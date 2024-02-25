import gulp from "gulp"

globs = PLATE_ENV.globs.assets

export default Assets = ->
  gulp.src globs.src, { base: PLATE_ROOT }
    .pipe gulp.dest globs.dest
