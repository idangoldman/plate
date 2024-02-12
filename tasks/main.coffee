import { deleteSync } from "del"
import browserSync from "browser-sync";
import coffee from "gulp-coffee"
import gulp from "gulp"
import slim from "./pipes/slim.coffee"
import splitMdIntoJsonAndHtml from "./pipes/split-md-into-json-and-html.coffee"
import stylus from "gulp-stylus"

import env, { globs, server } from "../config/environment.yml"

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

export serve = (done) ->
  browserSync.init
    server: globs.public
    port: server.port
  done()

export reload = (done) ->
  browserSync.reload()
  done()

export watch = () ->
  gulp.watch(globs.styles.input, gulp.series(styles, reload))
  gulp.watch(globs.scripts.input, gulp.series(scripts, reload))
  gulp.watch(globs.templates.input, gulp.series(templates, reload))
  return

export build = gulp.series(clean, gulp.parallel(styles, scripts, templates))
export dev = gulp.series(build, gulp.parallel(serve, watch))

export default (done) ->
  console.log env
  done()
