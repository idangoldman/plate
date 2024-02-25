import stylus from "gulp-stylus"

globs = PLATE_ENV.globs.styles

export default Styles = () ->
  gulp.src globs.src
    .pipe stylus()
    .pipe gulp.dest globs.dest
