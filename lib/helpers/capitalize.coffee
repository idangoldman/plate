export default capitalize = (str = "") ->
  unless str.length > 0 then "" else str.charAt(0).toUpperCase() + str.slice(1).toLowerCase()
