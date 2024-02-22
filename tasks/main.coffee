import { Serve } from "./dev-server.coffee"
import Assets from "./assets.coffee"
import Clean from "./clean.coffee"
import gulp from "gulp"
import Scripts from "./scripts.coffee"
import Styles from "./styles.coffee"
import Templates from "./templates.coffee"
import Watch from "./watch.coffee"

export Build = gulp.series(Clean, gulp.parallel(Assets, Styles, Scripts, Templates))
export Dev = gulp.series(build, gulp.parallel(Serve, Watch))

export default (done) ->
  console.log PLATE_ENV
  done()
