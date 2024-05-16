import get from "lodash/get.js"
import has from "lodash/has.js"
import path from "node:path"

import TaskPipe from "~/tasks/pipes/task.coffee"

class PlaceholdersPipe extends TaskPipe
  @newInstance: (options = {}) =>
    new @ "placeholders-pipe", options

  transpile: ({ contents }) ->
    placeholderPatterns = new RegExp "\\{\\{\\s*(?<placeholder>[a-z0-9-_.]+?)\\s*\\}\\}", "gmi"
    replacedContents = contents.replace placeholderPatterns, @process.bind(@)

    Promise.resolve
      contents: replacedContents

  process: (match, placeholder) ->
    if has @options, placeholder
      return get(@options, placeholder)

    match

export default PlaceholdersPipe.newInstance
