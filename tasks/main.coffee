import { serve } from "./dev-server.coffee"
import assets from "./assets.coffee"
import clean from "./clean.coffee"
import env from "../config/environment.yml"
import gulp from "gulp"
import scripts from "./scripts.coffee"
import styles from "./styles.coffee"
import templates from "./templates.coffee"
import watch from "./watch.coffee"


export build = gulp.series(clean, gulp.parallel(assets, styles, scripts, templates))
export dev = gulp.series(build, gulp.parallel(serve, watch))

export default (done) ->
  console.log env
  done()
