export default capitalize = (str) ->
  if str?.length then str.charAt(0).toUpperCase() + str.slice(1).toLowerCase() else ''
