import { globs } from "../config/environment.yml"
import gulp from "gulp"
import stylus from "gulp-stylus"

export default Styles = () ->
  gulp.src globs.styles.input
    .pipe stylus()
    .pipe gulp.dest globs.styles.output
