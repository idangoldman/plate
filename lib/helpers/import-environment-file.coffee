export importEnvironmentFile = (filePath) ->
  environtmentFile = {}

  try
    environtmentFile = (await import(filePath)).default
  catch error
    console.warn "No environment file found at #{filePath}"
  finally
    environtmentFile
