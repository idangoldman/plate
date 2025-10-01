export default eventNamesValidation = (eventNames = '', eventNamesList = []) ->
  names = eventNames.toArray(/\s+/)

  return if names.isEmpty() then []

  validList = eventNamesList.flatten()
  invalidList = names.filter((name) -> not validList.includes(name))

  unless invalidList.isEmpty()
    throw new Error "Invalid event name: #{invalidList.join(', ')}."

  return names
