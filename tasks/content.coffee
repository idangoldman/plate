import Markdown from "~/tasks/pipes/markdown.coffee"

globs = PLATE_ENV.globs.content

export default Content = () ->
  gulp.src globs.src
    .pipe Markdown()
    .pipe gulp.dest globs.dest
