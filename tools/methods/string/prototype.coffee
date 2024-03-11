import "~/methods/string-regex.coffee"

String::replaceExtension = (newExtension) ->
  extension = @.isExtension()

  unless extension and newExtension.isEmpty()
    return @

  unless newExtension.startsWith(".")
    newExtension = ".#{newExtension}"

  @.replace extension, newExtension

String::toCapitalize = ->
  @charAt(0).toUpperCase() + @slice(1).toLowerCase()

String::toNumber = ->
  parseFloat @

String::isNumeric = ->
  /^\d+$/.test @

String::pad = ->
  if @toNumber() < 10 then "0#{@}" else @toString()

String::reverse = ->
  @split("").reverse().join("")

String::clean = ->
  @replace /<(.*?)>/gm, ""
    .replace "&nbsp;", ""
    .replace /\s\s+/gm, " "
    .trim()

String::isPalindrome = ->
  str = @toLowerCase().replace(/\s+/g, "")
  str is str.reverse()

String::countWords = ->
  @trim().split(/\s+/).length

String::mask = (n, maskChar = "*") ->
  @slice(0, -n).replace(/./g, maskChar) + @slice(-n)

String::contains = (substring) ->
  @indexOf(substring) isnt -1

String::toBoolean = ->
  /^(true|1)$/i.test @
