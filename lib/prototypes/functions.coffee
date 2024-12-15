import Prototypes from "#root/patterns/prototypes.js"

export default class Functions extends Prototypes
  @extends "Function"

  isNativeMethod: ->
    @toString().includes "[native code]"

export methods = Functions.methods()
