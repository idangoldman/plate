import { $ } from "zx"
import TaskPipe from "@/tools/pipes/task.coffee"
import path from "node:path"

{ globs } = PLATE_ENV

class SlimPipe extends TaskPipe
  @newInstance: (options = {}) =>
    new @ "slim-pipe", options

  transpile: ({ file, contents }) ->
    try
      renderedContents = await @generate file.path
    catch error
      console.error error
      renderedContents = contents

    Promise.resolve
      contents: renderedContents

  generate: ( filePath ) ->
    slimBoot = path.join PLATE_PKG, "tools", "slim", "boot.rb"

    paths = JSON.stringify
      contents: filePath
      locales: path.join PLATE_ROOT, globs.locales
      logs: path.join PLATE_ROOT, globs.logs
      templates: path.join PLATE_ROOT, globs.templates.src

    $.verbose = false
    capture = await $"ruby #{slimBoot} #{paths}"
    # console.log capture
    if capture.stderr
      throw new Error capture

    capture.stdout

export default SlimPipe.newInstance
