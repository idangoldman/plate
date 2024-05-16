import gulp from "gulp";
global.gulp = gulp;

await import(PLATE_GULPFILE).then((gulpfile) => {
  for (const module in gulpfile) {
    if (typeof gulpfile[module] === "function") {
      gulp.task(module, gulpfile[module]);
    }
  }
}).catch((error) => {
  console.error(error);
});
