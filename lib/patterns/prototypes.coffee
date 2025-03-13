import capitalize from "#root/helpers/capitalize.js"
import isNativeMethod from "#root/helpers/is-native-method.js"
import Hooks from "#root/patterns/hooks.js"

export default class Prototypes
  @prefix: "___"
  @registry = new Map()
  @supported = new Set [
    "Array"
    "Function"
    "Object"
    "String"
  ]

  @after = (methodNames, handler) ->
    Hooks.classAfterHook @, methodNames, handler

  @around = (methodNames, handler) ->
    Hooks.classAroundHook @, methodNames, handler

  @before = (methodNames, handler) ->
    Hooks.classBeforeHook @, methodNames, handler

  @extends: (natives...) ->
    nativesToExtend = []

    for proto in natives.flat()
      nativeName = capitalize if typeof proto is 'string' then proto else proto.name

      unless @supported.has nativeName
        throw new Error "Unsupported prototype: #{nativeName}"

      protoObj = global[nativeName]?.prototype

      unless protoObj?
        throw new Error "Cannot find prototype for: #{nativeName}"

      nativesToExtend.push protoObj

    unless nativesToExtend.length
      throw new Error "No native prototypes to extend"

    @registry.set @name, nativesToExtend

    true

  @methods: ->
    Object.getOwnPropertyNames @prototype
      .filter (name) -> name isnt "constructor"
      .reduce (acc, name) =>
        acc[name] = @prototype[name]
        acc
      , {}

  @apply: ->
    nativePrototypes = @registry.get @name

    unless nativePrototypes?.length
      throw new Error "No native prototypes registered for #{@name}"

    methods = @methods()

    unless Object.keys(methods).length
      throw new Error "No methods defined in #{@name}"

    # Apply class hooks to methods
    methods = Hooks.applyClassHooks(@, methods)

    for name, fn of methods
      for proto in nativePrototypes

        if isNativeMethod proto[name]
          console.warn "Method #{name} is native on #{proto.constructor.name}"
          proto["#{@prefix}#{name}"] = proto[name]
          proto[name] = null

        if proto[name]? and not proto["#{@prefix}#{name}"]?
          console.warn """
            Method `#{name}` and `#{@prefix}#{name}` already exist on #{proto.constructor.name}
          """
          continue

        Object.defineProperty proto, name, {
          value: fn
          enumerable: false
          configurable: true
          writable: true
        }

    @

  @remove: ->
    nativePrototypes = @registry.get @name

    unless nativePrototypes?.length
      throw new Error "No native prototypes registered for #{@name}"

    methods = @methods()

    for name of methods
      for proto in nativePrototypes
        if proto["#{@prefix}#{name}"]?
          proto[name] = proto["#{@prefix}#{name}"]
          delete proto["#{@prefix}#{name}"]
        else
          delete proto[name]

    @
