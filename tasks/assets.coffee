import gulp from "gulp"

globs = {
  base: PLATE_ENV.globs.base,
  PLATE_ENV.globs.assets...
}

export default Assets = ->
  gulp.src globs.src, { base: globs.base }
    .pipe gulp.dest globs.dest
