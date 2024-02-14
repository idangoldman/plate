import { globs } from "../config/environment.yml"
import { reload } from "./dev-server.coffee"
import gulp from "gulp"
import scripts from "./scripts.coffee"
import styles from "./styles.coffee"
import templates from "./templates.coffee"

export default Watch = () ->
  gulp.watch(globs.styles.input, gulp.series(styles, reload))
  gulp.watch(globs.scripts.input, gulp.series(scripts, reload))
  gulp.watch(globs.templates.input, gulp.series(templates, reload))
  return
