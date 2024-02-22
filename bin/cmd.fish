#!/usr/bin/env fish

node --trace-warnings \
  --import ./utils/loaders/register.mjs \
  --import ./utils/global-plate-env.mjs \
  ./node_modules/gulp/bin/gulp \
  --gulpfile ./config/gulpfile.mjs \
  $argv
