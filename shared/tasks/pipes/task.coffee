import PluginError from "plugin-error"
import { Transform } from "node:stream"

export default class TaskPipe extends Transform
  @newInstance: (options = {}) =>
    # new @ "name-pipe", options
    new PluginError "task-pipe", "newInstance method not implemented"

  constructor: (name = "", @options = {}) ->
    super { objectMode: true }
    @name = name || "task-pipe"

  _transform: (file, encoding, done) ->
    unless file.isBuffer() or !file.isNull()
      done null, file
      return

    if file.isStream()
      @pipeError file.path, "Streams are not supported!"
      return

    try
      contents = file.contents.toString()

      @transpile(file, contents, @options).then (transpiled) ->
        done null, @processTranspiledFile(file, transpiled)

    catch error
      @pipeError file.path, error.message
      return

  transpile: (file, contents, options) ->
    @pipeError file.path, "Transpile method not implemented in #{@name}"

  processTranspiledFile: (original, transpiled) ->
    if transpiled.contents
      original.contents = Buffer.from transpiled.contents

    if transpiled.data
      original.data = { original.data..., transpiled.data...}

    if transpiled.file
      original = { original..., transpiled.file...}

    original

  pipeError: (file, message = "") ->
    if message
      message = "Pipe transfomation failed: #{message}"

    throw new PluginError @name, message, { fileName: file.path, showStack: false }
