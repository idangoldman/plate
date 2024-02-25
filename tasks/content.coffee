import gulp from "gulp"
import Markdown from "./pipes/markdown.coffee"

globs = PLATE_ENV.globs.content

export default Content = () ->
  gulp.src globs.src
    .pipe Markdown()
    .pipe gulp.dest globs.dest
