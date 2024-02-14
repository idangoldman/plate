import { globs } from "../config/environment.yml"
import gulp from "gulp"
import slim from "./pipes/slim.coffee"

export default Templates = () ->
  gulp.src globs.templates.input
    .pipe slim()
    .pipe gulp.dest globs.templates.output
