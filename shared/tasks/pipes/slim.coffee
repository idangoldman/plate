import { $ } from "zx"
import TaskPipe from "~/tasks/pipes/task.coffee"
import path from "node:path"

class SlimPipe extends TaskPipe
  @newInstance: (options = {}) =>
    new @ "slim-pipe", options

  transpile: ({ file, contents }) ->
    locals = JSON.stringify @options.locals || {}
    slimContents = contents

    $.cwd = path.join(PLATE_PKG, "tools", "templates");
    { stdout, stderr } = await $"echo #{slimContents} | ruby slim.rb #{locals}".quiet()

    if stderr
      throw new Error stderr

    contents = stdout
    file.path = file.path.replace(/(\.[^.]*)$/, ".html")

    return { file, contents }

export default SlimPipe.newInstance
