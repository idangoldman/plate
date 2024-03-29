import slim from "~/tasks/pipes/slim.coffee"
import rename from "gulp-rename"

globs = PLATE_ENV.globs.templates

export default Templates = () ->
  gulp.src globs.src, { since: gulp.lastRun(Templates) }
    .pipe slim()
    .pipe rename (file) =>
      file.extname = ".html"
    .pipe gulp.dest globs.dest
