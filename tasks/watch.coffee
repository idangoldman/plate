import { globs } from "../config/environment.yml"
import { Reload } from "./dev-server.coffee"
import gulp from "gulp"
import Scripts from "./scripts.coffee"
import Styles from "./styles.coffee"
import Templates from "./templates.coffee"

export default Watch = () ->
  gulp.watch(globs.styles.input, gulp.series(Styles, Reload))
  gulp.watch(globs.scripts.input, gulp.series(Scripts, Reload))
  gulp.watch(globs.templates.input, gulp.series(Templates, Reload))
  return
