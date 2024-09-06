import coffeescript from "coffeescript"

export transformCoffee = (source, filename) ->
  coffeescript.compile source.toString(),
    filename: filename
    inlineMap: true
