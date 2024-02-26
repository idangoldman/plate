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
      @pipeError file.path, 'Streams are not supported!'
      return

    try
      contents = file.contents.toString()

      @transpile(file, contents, @options).then (transpiled) ->
        if transpiled.contents
          file.contents = Buffer.from transpiled.contents

        if transpiled.data
          file.data = { file.data..., transpiled.data...}

        if transpiled.file
          file = { file..., transpiled.file...}

        done null, file

    catch error
      @pipeError file.path, error.message
      return

  transpile: (file, contents, options) ->
    @pipeError file.path, "Transpile method not implemented in #{@name}"

  pipeError: (file, message = '') ->
    if message
      message = "Pipe transfomation failed: #{message}"

    throw new PluginError @name, message, { fileName: file.path, showStack: false }
