import gulp from "gulp"
import slim from "~/tasks/pipes/slim.coffee"

globs = PLATE_ENV.globs.templates

export default Templates = () ->
  gulp.src globs.src
    .pipe slim()
    .pipe gulp.dest globs.dest
