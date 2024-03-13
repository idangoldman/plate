import slim from "~/tasks/pipes/slim.coffee"
import rename from "gulp-rename"

globs = PLATE_ENV.globs.templates

export default Templates = () ->
  gulp.src globs.src
    .pipe slim()
    .pipe rename (file) =>
      file.extname = ".html"
    .pipe gulp.dest globs.dest
