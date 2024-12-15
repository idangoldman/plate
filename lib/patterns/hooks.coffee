class Hooks
  @hooks = new Map()
  @wraps = -> Object.assign { before: [], after: [], around: [] }

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

  @wrapMethod = (target, methodName, implementation) ->
    hooks = @hooks.get(target)?.get(methodName)
    return implementation unless hooks?

    wrappedMethod = if hooks.before?.length
      do (implementation) -> ->
        hook.call(@, arguments...) for hook in hooks.before
        implementation.apply(@, arguments)
    else
      implementation

    wrappedMethod = if hooks.after?.length
      do (wrappedMethod) -> ->
        result = wrappedMethod.apply(@, arguments)
        hook.call(@, result, arguments...) for hook in hooks.after
        result
    else
      wrappedMethod

    if hooks.around?.length
      hooks.around.reduce (method, hook) ->
        -> hook.call(@, method.bind(@), arguments...)
      , wrappedMethod
    else
      wrappedMethod
