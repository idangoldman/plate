export safeCallback = (callback) ->
  error = null
  result = null

  try
    result = await callback()
  catch err
    error = err
  finally
    [error, result]

export safeReturnBool = (callback) ->
  [error] = await safeCallback callback

  not error

export safeReturnOrThrow = (callback) ->
  [error, result] = await safeCallback callback

  if error
    throw error

  result
