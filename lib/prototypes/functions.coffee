import Prototypes from "#root/patterns/prototypes.js"
import Hooks from "#root/patterns/hooks.js"

export default class Functions extends Prototypes
  @extends "Function"

  # before: (handler) ->
  #   target = @prototype ? @
  #   methodName = @name
  #   Hooks.before target, methodName, handler
  #   @
  after: (handler) -> Hooks::addHook "after", @, [@name], handler
  around: (handler) -> Hooks::addHook "around", @, [@name], handler
  before: (handler) -> Hooks::addHook "before", @, [@name], handler

  safely: (args...) ->
    functionName = @name or 'anonymous'

    error = null
    result = null

    try
      maybePromise = @apply null, args

      if maybePromise instanceof Promise
        result = await maybePromise
      else
        result = maybePromise

    catch caughtError
      error = {
        ...caughtError
        originalError: caughtError.message
        message: "Error in '#{functionName}': #{caughtError.message}"
      }

    finally
      [error, result]

  safelyReturnValue: (args...) ->
    [error, result] = await @safely args...
    result

  safelyOrFail: (args...) ->
    [error, result] = await @safely args...

    if error
      throw error

    result

  returnTrueOrFalse: (args...) ->
    [error] = await @safely args...

    not error

  isNativeMethod: ->
    @toString().includes "[native code]"

export methods = Functions.methods()
