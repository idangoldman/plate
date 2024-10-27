export default capitalize = (str) ->
  return '' unless str?.length
  str.charAt(0).toUpperCase() + str.slice(1).toLowerCase()
