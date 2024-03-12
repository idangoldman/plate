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
    localesPath = path.join PLATE_ROOT, globs.locales
    slimPath = path.join PLATE_PKG, "tools", "slim"
    templatesPath = path.join PLATE_ROOT, globs.templates.views

    print = await $"echo #{contents} | ruby #{slimPath}/lib.rb #{templatesPath} #{localesPath}".quiet()

    if print.stderr
      throw new Error print.stderr
    print.stdout

export default SlimPipe.newInstance
