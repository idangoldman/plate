import TaskPipe from "~/tasks/pipes/task.coffee"
import YAML from "js-yaml"

class MemorizePipe extends TaskPipe
  @newInstance: (options = {}) =>
    new @ "memorize-pipe", options

  transpile: (file, contents, options = {}) ->
    memorized = YAML.dump
      content: contents
      data: file.data... || {}

    file.path = file.path.replace(/(\.[^.]*)$/, ".yml")

    return { file, contents: memorized }

export default MemorizePipe.newInstance
