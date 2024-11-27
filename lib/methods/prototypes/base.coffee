import capitalize from "#root/helpers/capitalize.js"

export default class PrototypeBase
  @registry = new Map()
  @supported = new Set [
    "Array"
    "Date"
    "Function"
    "Map"
    "Number"
    "Object"
    "Promise"
    "RegExp"
    "Set"
    "String"
  ]

  @extends: (natives...) ->
    nativesToExtend = []

    for proto in natives.flat()
      nativeName = if typeof proto is 'string' then proto else proto.name
      capitalizedName = capitalize nativeName

      unless @supported.has capitalizedName
        throw new Error "Unsupported prototype: #{nativeName}"

      protoObj = global[capitalizedName]?.prototype

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

    for name, fn of methods
      for proto in nativePrototypes
        if proto[name]?
          console.warn "Method #{name} already exists on #{proto.constructor.name}"
          continue

        Object.defineProperty proto, name,
          value: fn
          enumerable: false
          configurable: true
          writable: true

    @

  @remove: ->
    nativePrototypes = @registry.get @name

    unless nativePrototypes?.length
      throw new Error "No native prototypes registered for #{@name}"

    methods = @methods()

    for name of methods
      for proto in nativePrototypes
        delete proto[name]

    @
