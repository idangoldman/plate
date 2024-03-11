import { $ } from "zx"
import TaskPipe from "~/tasks/pipes/task.coffee"
import path from "node:path"
import YAML from "yaml"

class SlimPipe extends TaskPipe
  @newInstance: (options = {}) =>
    new @ "slim-pipe", options

  transpile: ({ file, contents }) ->
    { stdout, stderr } = await @execute contents

    if stderr
      throw new Error stderr

    Promise.resolve
      contents: stdout

  execute: async ( contents ) ->
    yamlContents = YAML.parse contents
    $.cwd = path.join PLATE_PKG, "tools", "slim"
    { stdout, stderr } = await $"echo #{contents} | ruby lib.rb".quiet()

export default SlimPipe.newInstance
