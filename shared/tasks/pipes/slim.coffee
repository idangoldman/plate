import { $ } from "zx"
import TaskPipe from "~/tasks/pipes/task.coffee"
import path from "node:path"

{ globs } = PLATE_ENV

class SlimPipe extends TaskPipe
  @newInstance: (options = {}) =>
    new @ "slim-pipe", options

  transpile: ({ file, contents }) ->
    template = await @generate contents

    Promise.resolve
      contents: template

  generate: ( contents ) ->
    slimBoot = path.join PLATE_PKG, "tools", "slim", "boot.rb"

    paths = JSON.stringify
      locales: path.join PLATE_ROOT, globs.locales
      logs: path.join PLATE_ROOT, globs.logs
      templates: path.join PLATE_ROOT, globs.templates.views

    capture = await $"echo '#{contents}' | ruby #{slimBoot} #{paths} ".quiet()

    if capture.stderr
      throw new Error capture.stderr

    capture.stdout

export default SlimPipe.newInstance
