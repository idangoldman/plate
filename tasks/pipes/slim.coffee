import { $ } from "zx"
import PluginError from "plugin-error"
import TaskPipe from "../utils/task-pipe.coffee"

class SlimPipe extends TaskPipe
  @newInstance: (options = {}) =>
    new @ "slim-pipe", options

  transpile: (filePath, contents, options = {}) ->
    try
      locals = JSON.stringify options.locals || {}
      slimContents = contents

      { stdout, stderr } = await $"echo #{slimContents} | ruby ../utils/slim-to-html.rb #{locals}".quiet()

      if stderr
        throw new Error stderr

      contents = stdout
      filePath = filePath.replace(/\.slim$/, ".html")

    catch error
      throw new PluginError "slim-pipe", "Transpilation failed: #{error.message}", { showStack: true }

    return { filePath, contents }

export default SlimPipe.newInstance
