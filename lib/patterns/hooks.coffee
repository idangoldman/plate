export default class Hooks
  @hooks = new Map()
  @classHooks = new Map()
  @wraps = -> Object.assign { before: [], after: [], around: [] }

  # Instance/method level hooks
  @getOrCreateHooks = (target, methodName) ->
    targetHooks = @hooks.get(target) ? new Map()
    methodHooks = targetHooks.get(methodName) ? @wraps()

    unless targetHooks.has(methodName)
      targetHooks.set(methodName, methodHooks)

    @hooks.set(target, targetHooks) unless @hooks.has(target)

    methodHooks

  @addHook = (type, target, methodNames, handler) ->
    [methodNames].flat().forEach (name) =>
      hooks = @getOrCreateHooks(target, name)
      hooks[type].push(handler)
    @

  @before = (target, methodNames, handler) ->
    @addHook('before', target, methodNames, handler)

  @after = (target, methodNames, handler) ->
    @addHook('after', target, methodNames, handler)

  @around = (target, methodNames, handler) ->
    @addHook('around', target, methodNames, handler)

  # Class-level hooks management
  @getOrCreateClassHooks = (klass) ->
    hooks = @classHooks.get(klass) ? []
    @classHooks.set(klass, hooks) unless @classHooks.has(klass)
    hooks

  @registerClassHook = (type, klass, methodNames, handler) ->
    hooks = @getOrCreateClassHooks(klass)
    hooks.push {
      type: type
      methodNames: [methodNames].flat()
      handler: handler
    }
    klass

  @classBeforeHook = (klass, methodNames, handler) ->
    @registerClassHook('before', klass, methodNames, handler)

  @classAfterHook = (klass, methodNames, handler) ->
    @registerClassHook('after', klass, methodNames, handler)

  @classAroundHook = (klass, methodNames, handler) ->
    @registerClassHook('around', klass, methodNames, handler)

  @applyClassHooks = (klass, methods) ->
    hooks = @classHooks.get(klass) ? []
    return methods unless hooks.length

    for hookDef in hooks
      for methodName in hookDef.methodNames
        continue unless methods[methodName]?

        originalMethod = methods[methodName]

        switch hookDef.type
          when 'before'
            methods[methodName] = (args...) ->
              hookDef.handler.call(@, args...)
              originalMethod.apply(@, args)

          when 'after'
            methods[methodName] = (args...) ->
              result = originalMethod.apply(@, args)
              hookDef.handler.call(@, result, args...)
              result

          when 'around'
            methods[methodName] = (args...) ->
              boundOriginal = originalMethod.bind(@)
              hookDef.handler.call(@, boundOriginal, args...)

    methods

  # Method wrappers
  @wrapMethod = (target, methodName, implementation) ->
    hooks = @hooks.get(target)?.get(methodName)
    return implementation unless hooks?

    wrappedMethod = if hooks.before?.length
      do (implementation) -> ->
        for hook in hooks.before
          hook.call(@, arguments...)
        implementation.apply(@, arguments)
    else
      implementation

    wrappedMethod = if hooks.after?.length
      do (wrappedMethod) -> ->
        result = wrappedMethod.apply(@, arguments)
        for hook in hooks.after
          hook.call(@, result, arguments...)
        result
    else
      wrappedMethod

    if hooks.around?.length
      hooks.around.reduce (method, hook) ->
        -> hook.call(@, method.bind(@), arguments...)
      , wrappedMethod
    else
      wrappedMethod

  # Apply hooks to classes
  @applyToClass = (klass) ->
    proto = klass.prototype
    methodNames = Object.getOwnPropertyNames(proto).filter (name) ->
      name isnt 'constructor' and typeof proto[name] is 'function'

    for methodName in methodNames
      originalMethod = proto[methodName]
      proto[methodName] = @wrapMethod(proto, methodName, originalMethod)

    klass

  # Apply hooks to individual methods
  @applyToMethod = (target, methodName) ->
    return target unless target[methodName]?

    originalMethod = target[methodName]
    target[methodName] = @wrapMethod(target, methodName, originalMethod)

    target
