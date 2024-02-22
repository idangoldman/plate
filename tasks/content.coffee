import gulp from "gulp"
import ContentDataFromMD from "./pipes/content-data-from-md.coffee"

{ globs } = PLATE_ENV

export default Content = () ->
  gulp.src globs.content.input
    .pipe ContentDataFromMD()
    .pipe gulp.dest globs.content.output
