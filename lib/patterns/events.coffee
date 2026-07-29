import eventNamesValidation from '#root/src/helpers/event-names-validation.js'
import findReverseBranch from '#root/src/helpers/find-reverse-branch.js'

export default class Events
  constructor: (eventsList = [], @namespace = '') ->
    @EVENTS_LIST = [].concat(eventsList)
    @listeners = new Map()

    return @

  on: (eventNames, callback, once = false) ->
    validEventNames = @_validateEventNames(eventNames)

    for eventName in validEventNames
      @_bind(eventName, callback, once)

    return @

  off: (eventNames, callback) ->
    if eventNames
      validEventNames = @_validateEventNames(eventNames)

      for eventName in validEventNames
        @_unbind(eventName, callback)
    else
      @_unbind()

    return @

  once: (eventNames, callback) ->
    @on(eventNames, callback, true)

  emit: (eventNames, data) ->
    validEventNames = @_validateEventNames(eventNames)
    eventsList = findReverseBranch(validEventNames, @EVENTS_LIST)

    for storedEvent in eventsList
      storedEvent = @_createNamespacedEvent(storedEvent)
      callbacks = @listeners.get(storedEvent)

      if callbacks?.size
        for callback in callbacks
          if data
            callback.apply(null, data)
          else
            callback()

    return @

  has: (eventNames) ->
    validEventNames = @_validateEventNames(eventNames)

    for eventName in validEventNames
      storedEvent = @_createNamespacedEvent(eventName)
      callbacks = @listeners.get(storedEvent)

      if callbacks?.size > 0
        return @

    return false

  clear: ->
    @listeners.clear()
    return @

  _validateEventNames: (eventNames) ->
    eventNamesValidation(eventNames, @EVENTS_LIST)

  _createNamespacedEvent: (eventName = '') ->
    if @namespace then "#{@namespace}:#{eventName}" else eventName

  _bind: (eventName, callback, once = false) ->
    eventName = @_createNamespacedEvent(eventName)
    callbacks = @listeners.get(eventName) or new Set()

    unless callbacks.has(callback)
      if once
        callbackOnce = (args...) =>
          callback(args...)
          @_unbind(eventName, callbackOnce)
        callbacks.add(callbackOnce)

      else
        callbacks.add(callback)

      @listeners.set(eventName, callbacks)

  _unbind: (eventName, callback) ->
    eventName = @_createNamespacedEvent(eventName)

    if eventName and callback
      callbacks = @listeners.get(eventName)

      if callbacks?.has(callback)
        callbacks.delete(callback)
        @listeners.set(eventName, callbacks)

    else if not eventName
      @listeners.clear()

    else if not callback
      @listeners.set(eventName, new Set())
