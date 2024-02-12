import PluginError from 'plugin-error'
import { Transform } from 'node:stream'

export default class TaskPipe extends Transform
  @newInstance: (options = {}) =>
    # new @ "name-pipe", options
    new PluginError 'task-pipe', 'newInstance method not implemented'

  constructor: (name = '', @options = {}) ->
    super { objectMode: true }
    @name = name || 'task-pipe'

  _transform: (file, encoding, done) ->
    unless file.isBuffer() or !file.isNull()
      done null, file
      return

    if file.isStream()
      # done null, file
      done new PluginError @name, 'Streams are not supported!', { fileName: file.path }
      return

    try
      contents = file.contents.toString()
      filePath = file.path

      @transpile(filePath, contents, @options).then (transpiled) =>
        if transpiled.contents
          file.contents = Buffer.from transpiled.contents

        if transpiled.filePath
          file.path = transpiled.filePath

        done null, file

    catch error
      done new PluginError @name, error, { fileName: file.path, showStack: true }
      return

  transpile: (file, contents, options) ->
    throw new PluginError @name, 'Transpile method not implemented', { fileName: file.path }
