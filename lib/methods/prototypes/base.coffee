import Singleton from "#root/methods/singleton.js"
import Hooks from "#root/methods/hooks.js"

export default class PrototypeBase extends Singleton
  @registry = new Map()
  @applied = false

  @validExtends = new Set [
    "Array"
    "String"
    "Object"
    "Number"
    "Date"
    "RegExp"
    "Function"
  ]

  @before ['apply', 'remove'], { once: true }, -> @getInstance()

  @extends = (target) ->
    targetName = if typeof target is 'string' then target else target.name
    throw new Error "Invalid target: #{targetName}" unless @validTargets.has(targetName)

    @register(targetName)
    targetName

  @getPrototype = (name) ->
    return global[name].prototype if @validExtends.has(name)
    throw new Error "Invalid target: #{name}"

  @methods = ->
    Object.getOwnPropertyNames(@prototype).reduce (acc, name) =>
      return acc if name is 'constructor'
      acc[name] = (instance, ...args) =>
        @prototype[name].apply(instance, args)
      acc
    , {}

  @register = (target) ->
    throw new Error "Invalid target: #{target}" unless @validExtends.has(target)

    methods = Object.getOwnPropertyNames(@prototype).reduce (acc, name) =>
      return acc if name is 'constructor'
      method = @prototype[name]
      acc[name] = Hooks.wrapMethod(this, name, method)
      acc
    , {}

    @registry.set(target, {
      ...(if @registry.has(target) then @registry.get(target) else {})
      ...methods
    })
    @

  @apply = ->
    return if @applied

    @registry.forEach (methods, target) =>
      prototype = @getPrototype(target)

      Object.entries(methods).forEach ([name, implementation]) =>
        return if prototype[name]?

        Object.defineProperty prototype, name,
          configurable: true
          enumerable: false
          value: implementation
          writable: true

    @applied = true
    @

  @remove = ->
    return unless @applied

    @registry.forEach (methods, target) =>
      prototype = @getPrototype(target)
      Object.keys(methods).forEach (name) ->
        delete prototype[name]

    @applied = false
    @
