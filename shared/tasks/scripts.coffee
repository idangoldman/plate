import coffee from "gulp-coffee"
import { createGulpEsbuild } from "gulp-esbuild"

globs = PLATE_ENV.globs.scripts

export default Scripts = () ->
  gulp.src globs.src
    .pipe coffee bare: true

    .pipe createGulpEsbuild(pipe: true)
      bundle: true
      minify: true
      outfile: globs.outputFile
      sourcemap: true
      target: ["es6"]

    .pipe gulp.dest globs.dest
