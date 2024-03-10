import { $ } from "zx"
import TaskPipe from "~/tasks/pipes/task.coffee"
import path from "node:path"

class SlimPipe extends TaskPipe
  @newInstance: (options = {}) =>
    new @ "slim-pipe", options

  transpile: ({ file, contents }) ->
    locals = JSON.stringify @options.locals || {}

    $.cwd = path.join(PLATE_PKG, "tools", "slim");
    console.log locals
    { stdout, stderr } = await $"echo #{contents} | ruby lib.rb #{locals}".quiet()

    if stderr
      throw new Error stderr

    return
      contents: stdout

export default SlimPipe.newInstance
