import merge from "lodash/merge.js";
import { Transform } from "node:stream"
import PluginError from "plugin-error"

export default class TaskPipe extends Transform
  @newInstance: (options = {}) =>
    # new @ "name-pipe", options
    new PluginError "task-pipe", "newInstance method not implemented"

  constructor: (name = "", @options = {}) ->
    super { objectMode: true }
    @name = name || "task-pipe"

  @fileCheck: (file, next) =>
    unless file.isBuffer() or !file.isNull()
      next null, file
      return

    if file.isStream()
      @pipeError file.path, "Streams are not supported!"
      return

  _transform: (file, encoding, next) ->
    console.log "TASK Transforming #{@name}"
    TaskPipe.fileCheck file, next

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
      original.data = merge original.data, transpiled.data

    if transpiled.file
      original = merge original, transpiled.file
    original

  pipeError: (file, message = "") ->
    throw new PluginError @name, message, { fileName: file.path, showStack: true, showProperties: true}
