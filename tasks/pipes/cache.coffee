import PluginError from "plugin-error"
import YAML from "js-yaml"
import TaskPipe from "./task.coffee"

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
