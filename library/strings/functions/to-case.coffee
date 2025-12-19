import { CASE_SEPARATORS_UNICODE, CASE_WHITESPACE } from "~/library/utilities/regex.coffee"

export default toCase = (value = "") ->
  value.replace(CASE_SEPARATORS_UNICODE, " ").trim().toLowerCase().split(CASE_WHITESPACE)
