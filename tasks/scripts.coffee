import coffee from "gulp-coffee"
import gulp from "gulp"

globs = PLATE_ENV.globs.scripts

export default Scripts = () ->
  gulp.src globs.src
    .pipe coffee({bare: true})
    .pipe gulp.dest globs.dest
