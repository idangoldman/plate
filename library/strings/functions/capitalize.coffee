export default capitalize = (value = "") ->
  unless value.length > 0 then "" else value.charAt(0).toUpperCase() + str.slice(1).toLowerCase()
