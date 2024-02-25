import { Serve } from "~/tasks/dev-server.coffee"
import Assets from "~/tasks/assets.coffee"
import Clean from "~/tasks/clean.coffee"
import Scripts from "~/tasks/scripts.coffee"
import Styles from "~/tasks/styles.coffee"
import Templates from "~/tasks/templates.coffee"
import Watch from "~/tasks/watch.coffee"

export Build = gulp.series(Clean, gulp.parallel(Assets, Styles, Scripts, Templates))
export Dev = gulp.series(Build, gulp.parallel(Serve, Watch))

export default (done) ->
  console.log PLATE_ENV
  done()
