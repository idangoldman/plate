import MarkdownPipe from "~/tasks/pipes/markdown.coffee"
import PrettyURLsPipe from "~/tasks/pipes/pretty-urls.coffee"
import MemorizePipe from "~/tasks/pipes/memorize.coffee"

globs = PLATE_ENV.globs.content

export default Content = () ->
  gulp.src globs.src
    .pipe PrettyURLsPipe()
    .pipe MarkdownPipe()
    .pipe MemorizePipe()
    .pipe gulp.dest globs.dest
