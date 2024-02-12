import coffee from "gulp-coffee"
import gulp from "gulp"
import stylus from "gulp-stylus"
import { deleteSync } from "del"

import { globs } from "../config/environment.yml"
globs = environment.globs

export clean = (done) ->
  deleteSync globs.clean, { dot: true, force: true }
  done()

export styles = () ->
  gulp.src globs.styles.input
    .pipe stylus()
    .pipe gulp.dest globs.styles.output

export scripts = () ->
  gulp.src globs.scripts.input
    .pipe coffee({bare: true})
    .pipe gulp.dest globs.scripts.output

export templates = () ->
  gulp.src globs.templates.input
    .pipe slim()
    .pipe gulp.dest globs.templates.output

export build = gulp.series(clean, gulp.parallel(styles, scripts, templates))

export default (done) ->
  console.log environment
  done()
