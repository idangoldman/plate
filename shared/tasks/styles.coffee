import path from "node:path"
import stylus from "gulp-stylus"

globs = PLATE_ENV.globs.styles

export default Styles = () ->
  gulp.src globs.src
    .pipe stylus
      include: [
        path.join PLATE_ROOT, globs.src
        path.join PLATE_ROOT, "node_modules"
        path.join PLATE_ROOT, globs.assets
      ]
    .pipe gulp.dest globs.dest
