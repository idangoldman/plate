import Events from '#root/patterns/events.js'
import { DOM_EVENTS_LIST } from '#root/src/events/lists.json'

export default class DOMEvents extends Events
  constructor: (@element) ->
    super(DOM_EVENTS_LIST, 'dom')

  emit: ->
    throw new Error('DOM events cannot be emitted manually')

  clear: ->
    for [key, { eventName, callback }] from @listeners
      @element.raw.removeEventListener(eventName, callback, false)

    super.clear()

  # _createNamespacedEvent: (eventName) ->
  #   if @namespace then "#{@namespace}:#{eventName}" else eventName

  _bind: (eventName, callback, once = false) ->
    eventKey = "#{eventName}_#{callback.toString()}"

    unless @listeners.has(eventKey)
      @element.raw.addEventListener(eventName, callback, { once })
      @listeners.set(eventKey, { eventName, callback })

  _unbind: (eventName, callback) ->
    eventKey = "#{eventName}_#{callback.toString()}"

    if @listeners.has(eventKey)
      @element.raw.removeEventListener(eventName, callback, false)
      @listeners.delete(eventKey)
