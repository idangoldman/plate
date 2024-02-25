import { Reload } from "~/tasks/dev-server.coffee"
import gulp from "gulp"
import Scripts from "~/tasks/scripts.coffee"
import Styles from "~/tasks/styles.coffee"
import Templates from "~/tasks/templates.coffee"

{ globs } = PLATE_ENV

export default Watch = () ->
  gulp.watch(globs.styles.src, gulp.series(Styles, Reload))
  gulp.watch(globs.scripts.src, gulp.series(Scripts, Reload))
  gulp.watch(globs.templates.src, gulp.series(Templates, Reload))
  return
