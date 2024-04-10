import slim from "@/tools/pipes/slim.coffee"
import rename from "gulp-rename"

globs = PLATE_ENV.globs.templates

export default Templates = () ->
  gulp.src globs.content
    .pipe slim()
    .pipe rename (file) =>
      file.extname = ".html"
    .pipe gulp.dest globs.dest
