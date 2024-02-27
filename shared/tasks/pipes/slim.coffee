import { $ } from "zx"
import TaskPipe from "~/tasks/pipes/task.coffee"
import path from "node:path"

class SlimPipe extends TaskPipe
  @newInstance: (options = {}) =>
    new @ "slim-pipe", options

  transpile: (filePath, contents, options = {}) ->
    try
      locals = JSON.stringify options.locals || {}
      slimContents = contents

      # TODO: Use the `slimrb` gem inside a fish script instead of the `ruby slim.rb` command,
      # might be faster and more reliable. 🤷‍♂️
      $.cwd = path.join(PLATE_PKG, "tools", "templates");
      { stdout, stderr } = await $"echo #{slimContents} | ruby slim.rb #{locals}".quiet()

      if stderr
        throw new Error stderr

      contents = stdout
      filePath = filePath.replace(/(\.[^.]*)$/, ".html")

    catch error
      @pipeError filePath, error.message

    return { filePath, contents }

export default SlimPipe.newInstance
