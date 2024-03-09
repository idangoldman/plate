import path from "node:path"
import vinyl from "vinyl"
import YAML from "yaml"

import TaskPipe from "~/tasks/pipes/task.coffee"

class MemorizePipe extends TaskPipe
  @cache: {}

  @newInstance: (options = {}) =>
    if options.cached?
      return MemorizePipe.cache

    new @ "memorize-pipe", options

  _transform: (file, encoding, next) =>
    MemorizePipe.fileCheck file, next

    unless @dataIsCached file.path
      @saveDataToCache file.path, file.data

    next null, file

  dataIsCached: (filePath = "") ->
    MemorizePipe.cache[filePath] or false

  saveDataToCache: (filePath, contents) ->
    MemorizePipe.cache[filePath] = contents
    @push @createCacheFile filePath, contents

  createCacheFile: (filePath, contents) ->
    new vinyl
      path: filePath.replace /(\.[^.]*)$/, ".yml"
      contents: Buffer.from YAML.stringify contents

export default MemorizePipe.newInstance
