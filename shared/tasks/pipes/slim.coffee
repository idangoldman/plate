import { $ } from "zx"
import TaskPipe from "~/tasks/pipes/task.coffee"
import path from "node:path"

globs = PLATE_ENV.globs.templates

class SlimPipe extends TaskPipe
  @newInstance: (options = {}) =>
    new @ "slim-pipe", options

  transpile: ({ file, contents }) ->
    { stdout, stderr } = await @execute contents

    if stderr
      throw new Error stderr

    # console.log contents
    console.log stdout

    Promise.resolve
      contents: stdout

  execute: ( contents ) ->
    slimPath = path.join PLATE_PKG, "tools", "slim"
    templatesPath = path.join PLATE_ROOT, globs.views

    { stdout, stderr } = await $"echo #{contents} | ruby #{slimPath}/lib.rb #{templatesPath}".quiet()

export default SlimPipe.newInstance
