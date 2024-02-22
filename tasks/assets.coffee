import gulp from "gulp"

{ globs } = PLATE_ENV

export default Assets = ->
  gulp.src globs.assets.input, { base: globs.base }
    .pipe gulp.dest globs.assets.output
