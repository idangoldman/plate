import { globs } from "../config/environment.yml"
import gulp from "gulp"
import ContentDataFromMD from "./pipes/content-data-from-md.coffee"

export default Content = () ->
  gulp.src globs.content.input
    .pipe ContentDataFromMD()
    .pipe gulp.dest globs.content.output
