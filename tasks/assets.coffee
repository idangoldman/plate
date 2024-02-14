import { globs } from "../config/environment.yml"
import gulp from "gulp"

export default Assets = ->
  gulp.src globs.assets.input, { base: globs.base }
    .pipe gulp.dest globs.assets.output
