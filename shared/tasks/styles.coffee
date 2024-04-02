import path from "node:path"
import stylus from "gulp-stylus"

globs = PLATE_ENV.globs.styles

includesMap = globs.includes.map (include) -> path.join PLATE_ROOT, include

export default Styles = () ->
  gulp.src globs.src
    .pipe stylus
      include: includesMap
      'include css': true
    .pipe gulp.dest globs.dest
