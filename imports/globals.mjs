import gulp from "gulp";
global.gulp = gulp;

// global.PLATE_CONFIG = {};
// global.PLATE_ENV = process.env.PLATE_ENV || "development";
// global.PLATE_PKG = process.env.PLATE_PKG || path.join("..");
// global.PLATE_ROOT = process.env.PLATE_ROT || path.join(process.cwd());

global.PLATE_ENV  = {};
global.PLATE_PKG  = process.env.PLATE_PKG;
global.PLATE_ROOT = process.env.PLATE_ROOT;
