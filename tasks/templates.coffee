import gulp from "gulp"
import slim from "./pipes/slim.coffee"

{ globs } = PLATE_ENV

export default Templates = () ->
  gulp.src globs.templates.input
    .pipe slim()
    .pipe gulp.dest globs.templates.output
