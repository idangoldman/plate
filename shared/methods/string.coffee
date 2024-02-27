export EXTENSION_REGEX = new RegExp "(.[^.]*)$/"

String::replaceExtension = (newExtension) ->
  unless EXTENSION_REGEX.test(@) and newExtension and newExtension.length > 0
    return @

  unless newExtension.startsWith('.')
    newExtension = ".#{newExtension}"

  @.replace EXTENSION_REGEX, newExtension
