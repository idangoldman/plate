import { globs } from "../config/environment.yml"
import gulp from "gulp"
import splitMdIntoJsonAndHtml from "./pipes/split-md-into-json-and-html.coffee"

export default Content = () ->
  gulp.src globs.content.input
    .pipe splitMdIntoJsonAndHtml()
    .pipe gulp.dest globs.content.output
