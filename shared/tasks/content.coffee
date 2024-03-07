import Markdown from "~/tasks/pipes/markdown.coffee"
import PrettyURLs from "~/tasks/pipes/pretty-urls.coffee"
import Memorize from "~/tasks/pipes/memorize.coffee"

globs = PLATE_ENV.globs.content

export default Content = () ->
  gulp.src globs.src
    .pipe Memorize()
    .pipe PrettyURLs()
    .pipe Markdown()
    .pipe gulp.dest globs.dest
