import PluginError from "plugin-error"
import { Transform } from "node:stream"

export default class TaskPipe extends Transform
  @newInstance: (options = {}) =>
    # new @ "name-pipe", options
    new PluginError "task-pipe", "newInstance method not implemented"

  constructor: (name = "", @options = {}) ->
    super { objectMode: true }
    @name = name || "task-pipe"

  _flush: (next) =>
    console.log "Flushing #{@name}"
    next()

  _transform: (file, encoding, next) ->
    console.log "Transforming #{@name}"

    unless file.isBuffer() or !file.isNull()
      next null, file
      return

    if file.isStream()
      @pipeError file.path, "Streams are not supported!"
      return

    try
      contents = file.contents.toString()

      @transpile({ file, contents, @options }).then (transpiled) =>
        next null, @processTranspiledFile(file, transpiled)

    catch error
      @pipeError file.path, error
      return

  transpile: ({ file, contents, options }) ->
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
    throw new PluginError @name, message, { fileName: file.path, showStack: true, showProperties: true}
