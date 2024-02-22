import coffee from "gulp-coffee"
import gulp from "gulp"

{ globs } = PLATE_ENV

export default Scripts = () ->
  gulp.src globs.scripts.input
    .pipe coffee({bare: true})
    .pipe gulp.dest globs.scripts.output
