import path from "node:path"
import vinyl from "vinyl"
import YAML from "yaml"

import TaskPipe from "~/tasks/pipes/task.coffee"

MemorizedStore = {}

class MemorizePipe extends TaskPipe
  @newInstance: (options = {}) =>
    new @ "memorize-pipe", options

  _transform: (file, encoding, next) =>
    @fileCheck file, next

    unless MemorizePipe.dataIsCached file.path
      @saveDataToCache file.path, file.data

    next null, file

  saveDataToCache: (filePath, contents) ->
    MemorizedStore[filePath] = contents
    @push @createCacheFile filePath, contents

  createCacheFile: (filePath, contents) ->
    new vinyl
      path: filePath.replace /(\.[^.]*)$/, ".yml"
      contents: Buffer.from YAML.stringify contents

  @getAllCachedData: () ->
    MemorizedStore

  @getCachedData: (filePath = "") ->
    MemorizedStore[filePath] or {}

  @dataIsCached: (filePath = "") ->
    MemorizedStore[filePath] or false

export Memorized = MemorizePipe.getAllCachedData
export default MemorizePipe.newInstance
