String::toCase = (targetCase) ->
  words = @replace(/([A-Z])|(_)|(-)|(\.)/g, " $1").trim().toLowerCase().split(/\s+/)

  switch targetCase
    when 'camel'
      words.map((word, index) -> if index == 0 then word else word.charAt(0).toUpperCase() + word.slice(1)).join('')
    when 'snake'
      words.join('_')
    when 'kebab'
      words.join('-')
    when 'pascal'
      words.map((word) -> word.charAt(0).toUpperCase() + word.slice(1)).join('')
    when 'constant'
      words.join('_').toUpperCase()
    when 'dot'
      words.join('.')
    when 'path'
      words.join('/')
    when 'sentence'
      words.map((word, index) -> if index == 0 then word.charAt(0).toUpperCase() + word.slice(1) else word).join(' ')
    when 'title'
      words.map((word) -> word.charAt(0).toUpperCase() + word.slice(1)).join(' ')
    else
      @

String::toPascalCase = ->
  @toCase('pascal')

String::toConstantCase = ->
  @toCase('constant')

String::toDotCase = ->
  @toCase('dot')

String::toPathCase = ->
  @toCase('path')

String::toSentenceCase = ->
  @toCase('sentence')

String::toTitleCase = ->
  @toCase('title')
