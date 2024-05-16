import get from "lodash/get.js"
import has from "lodash/has.js"

import TaskPipe from "@/tasks/pipes/task.coffee"
import { PLACEHOLDERS } from "@/tools/regex.coffee"

class PlaceholdersPipe extends TaskPipe
  @newInstance: (options = {}) =>
    new @ "placeholders-pipe", options

  transpile: ({ contents }) ->
    replacedContents = contents.replace PLACEHOLDERS, @process.bind(@)

    Promise.resolve
      contents: replacedContents

  process: (match, placeholder) ->
    if has @options, placeholder
      return get(@options, placeholder)
        .replace(PLACEHOLDERS, @process.bind(@))

    match

export default PlaceholdersPipe.newInstance
