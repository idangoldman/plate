import Prototypes from "#root/patterns/prototypes.js"
import Hooks from "#root/patterns/hooks.js"

export default class Functions extends Prototypes
  @extends "Function"

  isNativeMethod: ->
    @toString().includes "[native code]"

  before: (handler) -> Hooks::addHook "before", @, [@name], handler
  around: (handler) -> Hooks::addHook "around", @, [@name], handler
  after: (handler) -> Hooks::addHook "after", @, [@name], handler

  after: (handler) ->
    target = @prototype ? @
    methodName = @name
    Hooks::addHook "after", target, methodName, handler
    @

  around: (handler) ->
    target = @prototype ? @
    methodName = @name
    Hooks::addHook "around", target, methodName, handler
    @

  before: (handler) ->
    target = @prototype ? @
    methodName = @name
    Hooks::addHook "before", target, methodName, handler
    @

export methods = Functions.methods()
