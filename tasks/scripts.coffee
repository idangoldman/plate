import { globs } from "../config/environment.yml"
import coffee from "gulp-coffee"
import gulp from "gulp"

export default Scripts = () ->
  gulp.src globs.scripts.input
    .pipe coffee({bare: true})
    .pipe gulp.dest globs.scripts.output
