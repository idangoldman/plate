import { $ } from "zx"
import TaskPipe from "~/tasks/pipes/task.coffee"
import path from "node:path"

{ globs } = PLATE_ENV

class SlimPipe extends TaskPipe
  @newInstance: (options = {}) =>
    new @ "slim-pipe", options

  transpile: ({ file, contents }) ->
    try
      template = await @generate contents
    catch error
      console.error error
      template = contents

    Promise.resolve
      contents: template

  generate: ( contents ) ->
    slimBoot = path.join PLATE_PKG, "tools", "slim", "boot.rb"

    paths = JSON.stringify
      locales: path.join PLATE_ROOT, globs.locales
      logs: path.join PLATE_ROOT, globs.logs
      templates: path.join PLATE_ROOT, globs.templates.views

    $.verbose = false
    capture = await $"echo #{contents} | ruby #{slimBoot} #{paths}"

    if capture.stderr
      throw new Error capture

    capture.stdout

export default SlimPipe.newInstance
