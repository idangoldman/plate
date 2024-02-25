import gulp from 'gulp'
import favicons from 'gulp-favicons'
import locale from '../locales/en.yml'

globs = PLATE_ENV.globs.manifest

WEB_MANIFEST =
  appDescription: locale.en.meta.description
  appleStatusBarStyle: "black-translucent"
  appName: locale.en.meta.publisher
  appShortName: locale.en.meta.publisher_initials
  background: locale.en.meta.background_color
  developerName: locale.en.meta.author
  developerURL: locale.en.meta.url
  html: 'manifest.html',
  display: "standalone"
  icons:
    android: true
    appleIcon: true
    appleStartup: true
    favicons: true
    windows: true
    yandex: true
  lang: locale.en.meta.lang
  manifestMaskable: false
  orientation: "any"
  path: "/manifest/"
  pipeHTML: true,
  pixel_art: false
  scope: "/"
  start_url: "/"
  theme_color: locale.en.meta.theme_color
  version: locale.en.meta.version

export default Manifest = (done) ->
  gulp.src globs.src
    .pipe favicons WEB_MANIFEST
    .pipe gulp.dest globs.dest
  done()
