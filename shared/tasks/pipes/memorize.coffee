import TaskPipe from "~/tasks/pipes/task.coffee"
import YAML from "js-yaml"

class MemorizePipe extends TaskPipe
  @cache: {}
  @newInstance: (options = {}) =>
    new @ "memorize-pipe", options

  transpile: ({ file, contents }) ->
    # if @loadFromCache({ file }).contents is contents
    #   Promise.resolve file: file, contents: contents
    # else
    #   @saveToCache { file, contents }
    #   Promise.resolve file: file, contents: contents

    # contents = YAML.dump file.data
    # file.path = file.path.replace(/(\.[^.]*)$/, ".yml")

  @saveToCache: ({ file, contents }) ->
    @cache[file.path] = contents

  @loadFromCache: ({ file }) ->
    @cache[file.path] || {}

export default MemorizePipe.newInstance
