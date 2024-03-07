import TaskPipe from "~/tasks/pipes/task.coffee"
import YAML from "js-yaml"

FILE_EXTENSION_REGEX = /(\.[^.]*)$/
FILE_CACHE_EXTENSION = ".yml"

class MemorizePipe extends TaskPipe
  @cache: {}
  @newInstance: (options = {}) =>
    new @ "memorize-pipe", options

  _transform: (file, encoding, next) =>
    MemorizePipe.fileCheck file, next

    console.log "Transforming #{@name}"
    next()

    # cachedFilePath = file.path.replace FILE_EXTENSION_REGEX, FILE_CACHE_EXTENSION

    # if cachedContents = @loadFromCache cachedFilePath
    #   Promise.resolve contents: cachedContents
    # else
    #   cachedContents = @saveToCache cachedFilePath, file.data
    #   Promise.resolve contents: cachedContents

  saveToCache: ( filePath, contents ) ->
    @cache[filePath] = contents

  loadFromCache: ( filePath ) ->
    @cache[filePath] or null

export default MemorizePipe.newInstance
