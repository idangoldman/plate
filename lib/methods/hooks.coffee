class Hooks
  @hooks = new Map()

  @addHook = (target, methodName, type, options, handler) ->
    if typeof options is 'function'
      handler = options
      options = {}

    targetHooks = @hooks.get(target) ? new Map()
    methodHooks = targetHooks.get(methodName) ? { before: [], after: [], around: [] }

    hookData = { handler, options }
    methodHooks[type].push(hookData)

    targetHooks.set(methodName, methodHooks)
    @hooks.set(target, targetHooks)
    @

  @before = (target, methodNames, options, handler) ->
    methodNames = [methodNames] unless Array.isArray(methodNames)
    methodNames.forEach (name) => @addHook(target, name, 'before', options, handler)
    @

  @after = (target, methodNames, options, handler) ->
    methodNames = [methodNames] unless Array.isArray(methodNames)
    methodNames.forEach (name) => @addHook(target, name, 'after', options, handler)
    @

  @around = (target, methodNames, options, handler) ->
    methodNames = [methodNames] unless Array.isArray(methodNames)
    methodNames.forEach (name) => @addHook(target, name, 'around', options, handler)
    @

  @wrapMethod = (target, methodName, implementation) ->
    targetHooks = @hooks.get(target)?.get(methodName)
    return implementation unless targetHooks?

    method = implementation

    if targetHooks.before?.length
      method = do (method) -> ->
        for hookData in targetHooks.before
          continue if hookData.options.once and hookData.executed
          hookData.handler.call(@, arguments...)
          hookData.executed = true if hookData.options.once
        method.apply(@, arguments)

    if targetHooks.after?.length
      method = do (method) -> ->
        result = method.apply(@, arguments)
        for hookData in targetHooks.after
          continue if hookData.options.once and hookData.executed
          hookData.handler.call(@, result, arguments...)
          hookData.executed = true if hookData.options.once
        result

    if targetHooks.around?.length
      for hookData in targetHooks.around
        method = do (method, hookData) -> ->
          continue if hookData.options.once and hookData.executed
          result = hookData.handler.call(@, method.bind(@), arguments...)
          hookData.executed = true if hookData.options.once
          result

    method
