import Markdown from "~/tasks/pipes/markdown.coffee"
import PrettyURLs from "~/tasks/pipes/pretty-urls.coffee"

globs = PLATE_ENV.globs.content

export default Content = () ->
  gulp.src globs.src
    .pipe PrettyURLs()
    .pipe Markdown()
    .pipe gulp.dest globs.dest
