import PluginError from "plugin-error"
import TaskPipe from "~/tasks/pipes/task.coffee"
import YAML from "js-yaml"

class CachePipe extends TaskPipe
  @newInstance: (options = {}) =>
    new @ "cache-pipe", options

  transpile: (file, contents, options = {}) ->
    cached = YAML.dump
      content: contents
      data: file.data... || {}

  file.path = file.path.replace(/\.[a-z]{2,5}$/i, ".yml")

    return { file, contents: cached }

export default CachePipe.newInstance
