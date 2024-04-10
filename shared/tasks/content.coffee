import path from "node:path"
import rename from "gulp-rename"

import Markdown from "@/tools/pipes/markdown.coffee"
import Memorize from "@/tools/pipes/memorize.coffee"
import PrettyURLs from "@/tools/pipes/pretty-urls.coffee"

globs = PLATE_ENV.globs.content

export default Content = (next) ->
  gulp.src globs.src, { base: '.' }
    # TODO: refactor this pipe as part of the PrettyURLs pipe
    .pipe rename (file) =>
      file.extname = ".html"

      if file.basename isnt "index"
        file.dirname = path.join file.dirname, file.basename
        file.basename = "index"

      # Remove the destination directory parts from the directory path
      for part in globs.dest.split(path.sep)
        PART_REGEX = new RegExp "^\/?#{part}", "i"
        file.dirname = file.dirname
          .replace PART_REGEX, ""
          .replace /^\/+/, ""

      return
    .pipe PrettyURLs()
    .pipe Markdown()
    .pipe Memorize()
    .pipe gulp.dest globs.dest
