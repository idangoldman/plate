import gulp from "gulp"
import stylus from "gulp-stylus"

{ globs } = PLATE_ENV

export default Styles = () ->
  gulp.src globs.styles.input
    .pipe stylus()
    .pipe gulp.dest globs.styles.output
