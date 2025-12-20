CASE_SEPARATORS_UNICODE = new RegExp "[^\\p{L}\\p{N}]+", "gu"
CASE_WHITESPACE = new RegExp "\\s+", "g"

export default toCase = (value = "") ->
  value.replace(CASE_SEPARATORS_UNICODE, " ")
    .trim()
    .toLowerCase()
    .split(CASE_WHITESPACE)
