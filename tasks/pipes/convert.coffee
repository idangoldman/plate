import YAML from "yaml"

import TaskPipe from "@/tasks/pipes/task.coffee"

class ConvertPipe extends TaskPipe
  @newInstance: (options = {}) =>
    new @ "convert-pipe", options

  transpile: ({ file, contents }) ->
    if @options.from is "yaml" and @options.to is "json"
      contents = JSON.stringify YAML.parse contents
      file.path = file.path.replace /\.ya?ml$/, ".json"

    if @options.from is "json" and @options.to is "yaml"
      contents = YAML.stringify JSON.parse contents
      file.path = file.path.replace /\.json$/, ".yaml"

    Promise.resolve
      contents: contents
      file: file

export default ConvertPipe.newInstance
