export importEnvironmentFile = (filePath) ->
  environtmentFile = undefined

  try
    environtmentFile = (await import(filePath)).default
  catch e
    console.warn "No environment file found at #{filePath}"
  finally
    environtmentFile
